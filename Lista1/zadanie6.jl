#Marek Świergoń 261750 Obliczenia Naukowe Lista 1, zadanie 6

function f(x::Float64)::Float64
  return sqrt(x^2 + 1) - 1
end

function g(x::Float64)::Float64
  return x^2 / (sqrt(x^2 + 1) + 1)
end

arg::Float64 = Float64(1.0/8.0)
i = -1
while (arg > 0.0)
  println(rpad(i, 20), rpad(arg, 40), rpad(f(arg), 40), rpad(g(arg), 40))
  global i = i - 1
  global arg /= Float64(8.0)
end