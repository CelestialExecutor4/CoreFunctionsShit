getgenv().Salad = {}

getgenv().Celestial.remote_spy = function()
    local suc, rec = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Insalad/ApiShit/refs/heads/main/RemoteSpy"))()
    end) 
    if not suc then 
        error("[ Celestial ]: Failed to load the remote spy: "..tostring(rec))
    end 
end 
