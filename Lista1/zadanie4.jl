#Marek Świergoń 261750 Obliczenia Naukowe Lista 1, zadanie 4

function findX()::Float64
  x::Float64 = Float64(1.0)
  xnew::Float64 = nextfloat(x)
  while (xnew * (Float64(1.0) / xnew) == Float64(1.0))
    x = xnew
    xnew = nextfloat(x)
  end
  return xnew
end

curX::Float64 = findX()
prevX::Float64 = prevfloat(curX)
println(curX)
println(curX * (Float64(1.0) / curX))
println(prevX * (Float64(1.0) / prevX))