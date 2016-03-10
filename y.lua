Y = function (f)
   return function(n)
      return (function(x)
		 return x(x) 
	      end)(function(x) return f(function(y) return x(x)(y) end) end)(n)
	  end
end

Z = function (f)
   return (function(x)
	      return f(function(y)
			  return (x(x))(y)
		       end)
	   end)(function(x)
		   return f(function(y)
			       return (x(x))(y)
			    end)
		end)
end

factorial = Y(function(f) return function(n) return n > 0 and n * f(n-1) or 1 end end)

print(factorial(10))
