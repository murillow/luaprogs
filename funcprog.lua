-- Functional programming in Lua
-- 

-- Basic concepts

-- Currying
-- yx.x
func = function(a) 
	return function(b) return a + b end 
end

-- Omega combinator
-- yx.(x x)
O = function(x) return x(x) end

-- Y combinator
-- yf.(yx.f(x x))(yx.f(x x))
Y = function (f)
	return (function (x)
		return f(x(x))
	end)(function (x)
		return f(x(x))
	end)
end

-- Y combinator with 1 argument
Y1 = function (f)
	return (function (x)
		return f(function(n)
			return (x(x))(n) end)
		end)(function(x) 
			return f(function(n)
				return (x(x))(n) end)
		end)
end

I = function(x) return x end

-----------------------------

function nonRecFact(f)
	return function(n)
		return n > 0 and n * f(n-1) or 1
	end
end

fact = Y1(nonRecFact)
print(fact(10))
