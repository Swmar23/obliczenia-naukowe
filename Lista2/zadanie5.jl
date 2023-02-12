#Marek Świergoń 261750 Obliczenia Naukowe Lista 2 zadanie 5

#równanie rekurencyjne dla FLoat32
function nextFloat32(p::Float32, r::Float32)
  nextP::Float32 = p + r*p*(1-p)
  return nextP
end

#równanie rekurencyjne dla Float64
function nextFloat64(p::Float64, r::Float64)
  nextP::Float64 = p + r*p*(1-p)
  return nextP
end

rfl32 = Float32(3.0)
rfl64 = Float64(3.0)

pfl32 = Float32(0.01)
pfl64 = Float64(0.01)

println(rpad(0, 3),
        " & ", rpad(pfl32, 30), 
        " & ", rpad(pfl32, 30), 
        " & ", rpad(pfl64, 30), 
        "\\\\\\hline")

#pierwsze 10 iteracji
for n in 1:10
  global pfl32 = nextFloat32(pfl32, rfl32)
  global pfl64 = nextFloat64(pfl64, rfl64)
  println(rpad(n, 3),
        " & ", rpad(pfl32, 30), 
        " & ", rpad(pfl32, 30), 
        " & ", rpad(pfl64, 30), 
        "\\\\\\hline")
end

#stosuję obcięcie
pfl32Cut = Float32(0.722)

println(rpad(10, 3)," & ", rpad(pfl32, 30)," & ", rpad(pfl32Cut, 30)," & ", rpad(pfl64, 30),"\\\\\\hline")

#kolejne 30 iteracji
for n in 11:40
  global pfl32 = nextFloat32(pfl32, rfl32)
  global pfl32Cut = nextFloat32(pfl32Cut, rfl32)
  global pfl64 = nextFloat64(pfl64, rfl64)
  println(rpad(n, 3),
          " & ", rpad(pfl32, 30), 
          " & ", rpad(pfl32Cut, 30), 
          " & ", rpad(pfl64, 30), 
          "\\\\\\hline")
end