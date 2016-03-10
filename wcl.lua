#!/usr/bin/env lua

function countchars(word)
   local chars = string.len(word)
   local yword = coroutine.yield(chars)
   countchars(yword)
end

local cochars = coroutine.create(countchars)

function countwords(line)
   local i, wordc, charc = 0, 0, 0

   for word in line:gmatch("%w+") do
      _, chars = coroutine.resume(cochars, word)
      charc, wordc = charc + chars, wordc + 1
   end

   local newline = coroutine.yield(charc, wordc)
   countwords(newline)
end

local cowords = coroutine.create(countwords)

function countlines()
   local chars, words, lines = 0, 0, 0
   local line = io.read("*line")

   while (line) do
      _, c, w = coroutine.resume(cowords, line)
      chars, words = chars + c, words + w
      lines = lines + 1
      line = io.read("*line")
   end

   return chars, words, lines
end

function getfilesize(fname)
   local file = io.open(fname)
   return file:seek("end")
end

function processfile(fname)
   io.input(fname)
   return getfilesize(fname), countlines()
end

function main()

   local fname = arg[1]

   if not fname then
      print("Missing filename!")
      os.exit(1)
   end

   local bytes, chars, words, lines = processfile(fname)
   print(string.format("  %s  %s  %s  %s  %s", 
		       lines, words, chars, bytes, fname))
end

main()