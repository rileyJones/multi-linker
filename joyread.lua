
local mutexS = 0


local function mutexLock(mutexF)
    mutexF:seek("set",0)
    mutexS = mutexF:read("*n")
    emu.print(mutexS)
    while mutexS == 1 do
        mutexS = mutexF:read("*n")
    end
    mutexS = 1
    mutexF:seek("set",0)
    local tmp = io.open("jread", "w")
    tmp:write(mutexS)
    io.close(tmp)
end

local function mutexUnlock(mutexF)
    mutexS = 0
    local tmp = io.open("jread", "w")
    tmp:write(mutexS)
    io.close(tmp)
end

local function jtoa(jreadVal)
    local tmp = io.open("jpip", "w")
    if jreadVal["up"] then
        tmp:write(1)
    else
        tmp:write(0)
    end
    tmp:write(" ")
    if jreadVal["down"] then
        tmp:write(1)
    else
        tmp:write(0)
    end
    tmp:write(" ")
    if jreadVal["left"] then
        tmp:write(1)
    else
        tmp:write(0)
    end
    tmp:write(" ")
    if jreadVal["right"] then
        tmp:write(1)
    else
        tmp:write(0)
    end
    tmp:write(" ")
    if jreadVal["A"] then
        tmp:write(1)
    else
        tmp:write(0)
    end
    tmp:write(" ")
    if jreadVal["B"] then
        tmp:write(1)
    else
        tmp:write(0)
    end
    tmp:write(" ")
    if jreadVal["start"] then
        tmp:write(1)
    else
        tmp:write(0)
    end
    tmp:write(" ")
    if jreadVal["select"] then
        tmp:write(1)
    else
        tmp:write(0)
    end
    io.close(tmp)
end

local function atoj(jreadVal)
    local tmp = io.open("jval", "r")
    if tmp:read("*n") == 1 then
        jreadVal["up"] = true
    else
        jreadVal["up"] = false
    end
    if tmp:read("*n") == 1 then
        jreadVal["down"] = true
    else
        jreadVal["down"] = false
    end
    if tmp:read("*n") == 1 then
        jreadVal["left"] = true
    else
        jreadVal["left"] = false
    end
    if tmp:read("*n") == 1 then
        jreadVal["right"] = true
    else
        jreadVal["right"] = false
    end
    if tmp:read("*n") == 1 then
        jreadVal["A"] = true
    else
        jreadVal["A"] = false
    end
    if tmp:read("*n") == 1 then
        jreadVal["B"] = true
    else
        jreadVal["B"] = false
    end
    if tmp:read("*n") == 1 then
        jreadVal["start"] = true
    else
        jreadVal["start"] = false
    end
    if tmp:read("*n") == 1 then
        jreadVal["select"] = true
    else
        jreadVal["select"] = false
    end
    io.close(tmp)
end



while true do
    local jreadVal = joypad.read(1);
--    local mutexF   = io.open("jread", "r");
--    mutexLock(mutexF);
    jtoa(jreadVal)
--    mutexUnlock(mutexF);
    emu.frameadvance();
end
