local inf
local sup

repeat
   print("Entre com um número")
   inf = io.read()
   print("Entre com outro número")
   sup = io.read()
   
   if (sup - inf) < 20 then
      print("Segundo - Primeiro deve ser >= 20")
   end
until (sup - inf) >= 20

math.randomseed(os.time())

print(string.format("Estou pensando em um numero entre %d e %d (incl.)", inf, sup))
local num = math.random(inf, sup)

local tentativas = 0
local maximo = math.floor(math.log(sup - inf)/math.log(2))
local palpite

while tentativas <= maximo do
   print("Tente adivinhar o numero no qual pensei")

   tentativas = tentativas + 1
   palpite = tonumber(io.read())
   print(tentativas)

   if palpite == num then
      break
   elseif palpite < num then
      print("Palpite baixo, tente novamente")
   elseif palpite > num then
      print("Palpite alto, tente novamente")
   end
end

if palpite == num then
   print(string.format("Voce acertou em %d tentativas, parabens!", tentativas))
else
   print(string.format("Nao foi dessa vez... tente novamente"))
end
