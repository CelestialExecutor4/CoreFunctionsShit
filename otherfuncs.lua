-- important stuff goes here

local HttpService = game:GetService("HttpService")

-- Assuming Bridge:InternalRequest is already defined and works as is.

-- Hook Function: Sends a request to hook the given function with custom logic.
function hookfunction(name, hook)
    -- Prepare the request body
    local body = {
        Url = '/hook',  -- Endpoint for hooking
        functionName = name,  -- The name of the function to hook
        hookFunction = HttpService:JSONEncode(hook)  -- Serialize the hook function
    }
    
    -- Send the request using InternalRequest
    local response = Bridge:InternalRequest(body)

    -- Handle response (optional, depending on server behavior)
    if response then
        print("Successfully hooked function: " .. name)
    else
        error("Failed to hook function: " .. name)
    end
end

-- Return Function: Sends a request to return the function to its original state.
function returnfunction(name)
    -- Prepare the request body
    local body = {
        Url = '/return',  -- Endpoint for unhooking or restoring
        functionName = name  -- The name of the function to restore
    }

    -- Send the request using InternalRequest
    local response = Bridge:InternalRequest(body)

    -- Handle response (optional, depending on server behavior)
    if response then
        print("Successfully returned function: " .. name)
    else
        error("Failed to return function: " .. name)
    end
end
