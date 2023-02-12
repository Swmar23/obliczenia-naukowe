#Marek Świergoń 261750 Obliczenia Naukowe Lista 1, zadanie 3

using Printf

#funkcja działa powoli nawet dla małych przedziałów, do użycia wyłącznie by odkryć kroki,
#nie by przechodzić po całym przedziale!!!
function printSteps(a::Float64, b::Float64)
  step::Float64 = 0.0
  aNew::Float64 = a
  while(aNew <= b)
    aNew = nextfloat(a)
    stepNew::Float64 = aNew - a
    if(stepNew != step)
      @printf("Nowy krok: %0.52f, pomiędzy %0.52f i %0.52f", stepNew, a, aNew);
      step = stepNew
    end
    a = aNew
  end
end

function printBits(start::Float64, step::Float64, n::Int)
  num::Float64 = start
  while (n > 0)
    println(bitstring(num))
    num = num + step
    n = n-1
  end
end

# printSteps(Float64(1.0), Float64(2.0))
printBits(Float64(1.0), 0.0000000000000002220446049250313080847263336181640625, 10)

# printSteps(Float64(0.5), Float64(1.0))
printBits(Float64(0.5), 0.0000000000000001110223024625156540423631668090820312, 10)

# printSteps(Float64(2.0), Float64(4.0))
printBits(Float64(2.0), 0.0000000000000004440892098500626161694526672363281250, 10)