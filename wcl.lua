#!/usr/bin/env lua

-- a line, word, character and bytes counter

local function countchars(word)
    local chars = string.len(word)
    local yword = coroutine.yield(chars)
    countchars(yword)
end

local _chars = coroutine.create(countchars)

local function countwords(line)
    local wordc, charc = 0, 0

    for word in line:gmatch("%w+") do
        _, chars = assert(coroutine.resume(_chars, word))
        charc, wordc = charc + chars, wordc + 1
    end

    local newline = coroutine.yield(charc, wordc)
    countwords(newline)
end

local _words = coroutine.create(countwords)

local function countlines()
    local chars, words, lines = 0, 0, 0
    local line = assert(io.read("*line"), "Reading failure!")

    while (line) do
        local _, c, w = assert(coroutine.resume(_words, line))
        chars, words = chars + c, words + w
        lines = lines + 1
        line = io.read("*line")
    end

    return chars, words, lines
end

local function countbytes(fname)
    local file = assert(io.open(fname), "Failed to open file!")

    return file:seek("end")
end

local function main()
    local fname = arg[1]

    if not fname then
        print("Missing filename!")
        os.exit(1)
    end

    io.input(fname)
    
    local bytes, chars, words, lines = countbytes(fname), countlines()

    print(string.format(" %s %s %s %s %s",
            lines, words, chars, bytes, fname))
end

main()
