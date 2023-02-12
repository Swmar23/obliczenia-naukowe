#Marek Świergoń 261750 Obliczenia Naukowe Lista 1, zadanie 7

function f(x::Float64)::Float64
  return sin(x) + cos(3*x)
end

function derivative(x::Float64)::Float64
  return cos(x) - 3*sin(3*x)
end

function aproxderivative(x::Float64, h::Float64)::Float64
  return (f(x+h) - f(x))/h
end

h::Float64 = 1.0
i = 0

while i <= 54
  println(rpad(i, 10), rpad(derivative(Float64(1.0)), 40), rpad(aproxderivative(Float64(1.0), h), 40), rpad(abs(derivative(Float64(1.0)) - aproxderivative(Float64(1.0), h)), 40), rpad(Float64(1.0)+h, 40))
  global i += 1
  global h /= 2
end


