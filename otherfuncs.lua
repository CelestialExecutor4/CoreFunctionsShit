getgenv().cclosure = function(nelems, env)
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

getgenv().lclosure = function(nelems, env)
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

getgenv().upvalue = function()
    local upval = {
        value = nil,
    }
    return upval
end

getgenv().findUpvalue = function(openUpvals, level)
    for _, upval in ipairs(openUpvals) do
        if upval.level == level then
            return upval
        end
    end

    local new_upval = getgenv().upvalue()
    new_upval.level = level
    table.insert(openUpvals, new_upval)
    return new_upval
end

getgenv().closeUpvalues = function(openUpvals, level)
    for i = #openUpvals, 1, -1 do
        local upval = openUpvals[i]
        if upval.level >= level then
            upval.closed = true
            upval.value = upval.value or nil
            table.remove(openUpvals, i)
        end
    end
end

getgenv().getLocalName = function(proto, localNumber, pc)
    local count = 0
    for _, locvar in ipairs(proto.locvars) do
        if locvar.startpc <= pc and pc < locvar.endpc then
            count = count + 1
            if count == localNumber then
                return locvar.varname
            end
        end
    end
    return nil
end
