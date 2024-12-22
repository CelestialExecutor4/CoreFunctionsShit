getgenv().getconnections = newcclosure(function(sig)
    local Cons = GetCons(sig)
    local Ret = {}

    for Idx, Con in pairs(Cons) do
        if ConCache[Con] then
            Ret[Idx] = ConCache[Con]
        else
            local CTable = 
            {
                 __OBJECT = Con,
                 __OBJECT_ENABLED = true
            }
    
            Ret[Idx] = setmetatable(CTable, ConnMT)
            ConCache[Con] = Ret[Idx]
        end
    end

    return Ret
end)
