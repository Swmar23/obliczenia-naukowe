#Marek Świergoń 261750 Obliczenia Naukowe Lista 2 zadanie 6

#równanie rekurencyjne dla Float64
function nextFloat64(x::Float64, c::Float64)
  nextX::Float64 = x*x + c
  return nextX
end

# zmienne x1-x7 to punkty początkowe dla podpunktów odpowiednio od 1 do 7
# c1 = -2 (do podpunktów 1-3), c2 = -1 (do podpunktów)
println("******** c = -2 ********")
c1 = Float64(-2.0)
x1 = Float64(1.0)
x2 = Float64(2.0)
x3 = Float64(1.99999999999999)

println(rpad("n", 5), " & ", rpad("\$x_0=1\$", 25), " & ", rpad("\$x_0=2\$", 25), " & ", rpad("\$x_0=1.99999999999999\$", 25), " \\\\\\hline")

for n in 1:40
  global x1 = nextFloat64(x1, c1)
  global x2 = nextFloat64(x2, c1)
  global x3 = nextFloat64(x3, c1)
  println(rpad(n, 5),
      " & ", rpad(x1, 25), 
      " & ", rpad(x2, 25), 
      " & ", rpad(x3, 25), 
      " \\\\\\hline")
end


println("******** c = -1 ********")
c2 = Float64(-1.0)
x4 = Float64(1.0)
x5 = Float64(-1.0)
x6 = Float64(0.75)
x7 = Float64(0.25)

println(rpad("n", 5), " & ", rpad("\$x_0=1\$", 25), " & ", rpad("\$x_0=-1\$", 25), " & ", rpad("\$x_0=0.75\$", 25), " & ", rpad("\$x_0=0.25\$", 25), " \\\\\\hline")

for n in 1:40
  global x4 = nextFloat64(x4, c2)
  global x5 = nextFloat64(x5, c2)
  global x6 = nextFloat64(x6, c2)
  global x7 = nextFloat64(x7, c2)
  println(rpad(n, 5),
      " & ", rpad(x4, 25), 
      " & ", rpad(x5, 25), 
      " & ", rpad(x6, 25), 
      " & ", rpad(x7, 25), 
      " \\\\\\hline")
end