--[[ 
   ______     __          __  _       __
  / ____/__  / /__  _____/ /_(_)___ _/ /  
 / /   / _ \/ / _ \/ ___/ __/ / __ `/ /  
/ /___/  __/ /  __(__  ) /_/ / /_/ / /  
\____/\___/_/\___/____/\__/_/\__,_/_/   
          [ Custom Functions ]                     
]]

-- Define simulated closures and upvalue handling
do
    local registry = {}

    -- Simulate upvalues in a closure
    local function createClosure(func, upvalues)
        return {
            func = func,
            upvalues = upvalues or {}
        }
    end

    -- Simulate setting a closure value in the registry
    local function setClosureValue(name, closure)
        registry[name] = closure
    end

    -- Simulate getting a closure value from the registry
    local function getClosureValue(name)
        return registry[name]
    end

    -- Hook function with upvalue and closure support
    function hookfunction(original, hook)
        if type(original) ~= "function" then
            error("The first argument must be a function (original function).")
        end

        if type(hook) ~= "function" then
            error("The second argument must be a function (hook function).")
        end

        -- Wrap original and hook in closures
        local originalClosure = createClosure(original)
        local hookClosure = createClosure(hook)

        -- Store the original function in the registry to prevent GC issues
        local originalName = "original_" .. tostring(original)
        setClosureValue(originalName, originalClosure)

        -- Replace the original function with the hooked one
        local hookedFunction = function(...)
            return hook(original, ...)
        end

        local hookedClosure = createClosure(hookedFunction)

        -- Store the hooked function in the registry
        local hookedName = "hooked_" .. tostring(original)
        setClosureValue(hookedName, hookedClosure)

        -- Return the original function reference
        return function(...)
            return originalClosure.func(...)
        end
    end

    -- Example of using hookfunction
    getgenv().hookfunction = hookfunction
end
