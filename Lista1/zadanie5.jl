#Marek Świergoń 261750 Obliczenia Naukowe Lista 1, zadanie 5

function forwardFL64(x, y)::Float64
  sum::Float64 = 0.0
  if (length(x) == length(y))
    for i in (1:length(x))
      sum += x[i]*y[i]
    end
  end
  return sum
end

function backwardFL64(x, y)::Float64
  sum::Float64 = 0.0
  if (length(x) == length(y))
    for i in (length(x):-1:1)
      sum += x[i]*y[i]
    end
  end
  return sum
end

function ascendingFL64(x, y)::Float64
  sumPositives::Float64 = 0.0
  sumNegatives::Float64 = 0.0
  sum::Float64 = 0.0
  if (length(x) == length(y))
    products = Array{Float64}(undef, length(x))
    for i in (1:length(x))
      products[i] = x[i]*y[i]
    end
    sort!(products, by=abs, rev=true)
    for i in (1:length(x))
      if (products[i] >= 0.0)
        sumPositives += products[i]
      end
    end

    for i in (length(x):-1:1)
      if (products[i] < 0.0)
        sumNegatives += products[i]
      end
    end
    sum = sumPositives + sumNegatives
  end
  return sum
end

function descendingFL64(x, y)::Float64
  sumPositives::Float64 = 0.0
  sumNegatives::Float64 = 0.0
  sum::Float64 = 0.0
  if (length(x) == length(y))
    products = Array{Float64}(undef, length(x))
    for i in (1:length(x))
      products[i] = x[i]*y[i]
    end
    sort!(products, by=abs, rev=true)
    for i in (length(x):-1:1)
      if (products[i] >= 0.0)
        sumPositives += products[i]
      end
    end

    for i in (1:length(x))
      if (products[i] < 0.0)
        sumNegatives += products[i]
      end
    end
    sum = sumPositives + sumNegatives
  end
  return sum
end

function forwardFL32(x, y)::Float32
  sum::Float32 = 0.0
  if (length(x) == length(y))
    for i in (1:length(x))
      sum += x[i]*y[i]
    end
  end
  return sum
end

function backwardFL32(x, y)::Float32
  sum::Float32 = 0.0
  if (length(x) == length(y))
    for i in (length(x):-1:1)
      sum += x[i]*y[i]
    end
  end
  return sum
end

function ascendingFL32(x, y)::Float32
  sumPositives::Float32 = 0.0
  sumNegatives::Float32 = 0.0
  sum::Float32 = 0.0
  if (length(x) == length(y))
    products = Array{Float32}(undef, length(x))
    for i in (1:length(x))
      products[i] = x[i]*y[i]
    end
    sort!(products, by=abs, rev=true)
    for i in (1:length(x))
      if (products[i] >= 0.0)
        sumPositives += products[i]
      end
    end

    for i in (length(x):-1:1)
      if (products[i] < 0.0)
        sumNegatives += products[i]
      end
    end
    sum = sumPositives + sumNegatives
  end
  return sum
end

function descendingFL32(x, y)::Float32
  sumPositives::Float32 = 0.0
  sumNegatives::Float32 = 0.0
  sum::Float32 = 0.0
  if (length(x) == length(y))
    products = Array{Float32}(undef, length(x))
    for i in (1:length(x))
      products[i] = x[i]*y[i]
    end
    sort!(products, by=abs, rev=true)
    for i in (length(x):-1:1)
      if (products[i] >= 0.0)
        sumPositives += products[i]
      end
    end

    for i in (1:length(x))
      if (products[i] < 0.0)
        sumNegatives += products[i]
      end
    end
    sum = sumPositives + sumNegatives
  end
  return sum
end



xfl32 = [Float32(2.718281828), Float32(-3.141592654), Float32(1.414213562), Float32(0.5772156649), Float32(0.3010299957)]
yfl32 = [Float32(1486.2497), Float32(878366.9879), Float32(-22.37492), Float32(4773714.647), Float32(0.000185049)]

println(forwardFL32(xfl32, yfl32))
println(backwardFL32(xfl32, yfl32))
println(ascendingFL32(xfl32, yfl32))
println(descendingFL32(xfl32, yfl32))

xfl64 = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
yfl64 = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

println(forwardFL64(xfl64, yfl64))
println(backwardFL64(xfl64, yfl64))
println(ascendingFL64(xfl64, yfl64))
println(descendingFL64(xfl64, yfl64))
 

      