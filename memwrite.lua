
local mutexS = 0

local function mutexLock(mutexF)
    mutexS = mutexF:read("*n")
    while mutexS ~= 0  do
        emu.print(mutexS)
        emu.frameadvance();
        mutexS = mutexF:read("*n")
    end
    mutexS = 0
    mutexF:seek("set",0)
    local tmp = io.open("mread", "w")
    tmp:write(mutexS)
    io.close(tmp)
end


local function mutexUnlock(mutexF)
    mutexS = 2
    local tmp = io.open("mread", "w")
    tmp:write(mutexS)
    io.close(tmp)
end

local function mtoa()
    local tmp = io.open("mval", "w")
    for i = 0, 0xffff, 1 do
           tmp:write(memory.readbyte(i))
           tmp:write(" ")
    end
    io.close(tmp)
end

local function atom()
    local tmp = io.open("mval", "r")
--    for i = 0, 0xffff, 1 do
--        tmpval = tmp:read("*n")
--        if not tmpval then
--            break
--        end
--        memory.writebyte(i, tmpval)
--    end
   io.close(tmp)
end



while true do
    local mutexF   = io.open("mread", "r");
--    mutexLock(mutexF);
    atom()
--    mutexUnlock(mutexF);
    emu.frameadvance();
end
