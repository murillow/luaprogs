function hanoi (numDisks, from, to, aux)
   if numDisks == 1 then
      print("Movendo de " .. from .. " para " .. to)
   else
      hanoi(numDisks - 1, from, aux, to)
      print("Movendo de " .. from .. " para " .. to)
      hanoi(numDisks - 1, aux, to, from)
   end
end

print("Quantos discos? ")
local numDisks = tonumber(io.read())

print("Num. de movimentos: " .. math.pow(2, numDisks) - 1)

hanoi(numDisks, 'A', 'C', 'B')