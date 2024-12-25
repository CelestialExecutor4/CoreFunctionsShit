getgenv().hookfunction = function(original, hook)
    if type(original) ~= "function" then
        error("The first arg must be a function (original func).")
    end
    if type(hook) ~= "function" then
        error("The second arg must be a function (hook).")
    end
    local info = debug.getinfo(original)
    local name = info and info.name or tostring(original)
    getgenv().ogfs[name] = original 
    local hooked = function(...)
        return hook(...)
    end
    getgenv()[name] = hooked  
    return hooked
end
getgenv().restorefunction = function(original)
    if type(original) ~= "function" then
        error("The argument must be a function (original func).")
    end
    for name, func in pairs(getgenv().ogfs) do
        if func == original then
            getgenv()[name] = original  
            getgenv().ogfs[name] = nil  
            return
        end
    end
    error("No original function found to restore.")
end
