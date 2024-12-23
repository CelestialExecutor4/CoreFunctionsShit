-- Implementation of Prototypes, Closures, and Upvalues in Roblox Lua
-- shit implementation

-- Create a new prototype
getgenv().newproto = function()
    return {
        source = nil,
        sizelocvars = 0,
        locvars = {},
    }
end

-- Create a new CClosure
getgenv().newcclosure = function(nelems, env)
    local closure = {
        isC = true,
        env = env,
        nupvalues = nelems,
        upvalues = {},
    }
    for i = 1, nelems do
        closure.upvalues[i] = nil
    end
    return closure
end

-- Create a new LClosure
getgenv().newlclosure = function(nelems, env)
    local closure = {
        isC = false,
        env = env,
        nupvalues = nelems,
        upvalues = {},
    }
    for i = 1, nelems do
        closure.upvalues[i] = nil
    end
    return closure
end

-- Create a new Upvalue
getgenv().newupval = function()
    local upval = {
        value = nil,
    }
    return upval
end

-- Find an existing upvalue or create a new one
getgenv().findupval = function(openupvals, level)
    for _, upval in ipairs(openupvals) do
        if upval.level == level then
            return upval
        end
    end
    local new_upval = getgenv().newupval()
    new_upval.level = level
    table.insert(openupvals, new_upval)
    return new_upval
end

-- Close upvalues from a given stack level
getgenv().closeupvals = function(openupvals, level)
    for i = #openupvals, 1, -1 do
        local upval = openupvals[i]
        if upval.level >= level then
            upval.closed = true
            upval.value = upval.value or nil
            table.remove(openupvals, i)
        end
    end
end

-- Free a prototype
getgenv().freeproto = function(proto)
    for k in pairs(proto) do
        proto[k] = nil
    end
end

-- Free a closure
getgenv().freeclosure = function(closure)
    for k in pairs(closure) do
        closure[k] = nil
    end
end

-- Free an upvalue
getgenv().freeupval = function(upval)
    for k in pairs(upval) do
        upval[k] = nil
    end
end

-- Get local variable name
getgenv().getlocalname = function(proto, local_number, pc)
    local count = 0
    for _, locvar in ipairs(proto.locvars) do
        if locvar.startpc <= pc and pc < locvar.endpc then
            count = count + 1
            if count == local_number then
                return locvar.varname
            end
        end
    end
    return nil
end
