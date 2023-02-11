# Marek Świergoń 261750 Obliczenia Naukowe Lista 5
# Program badający złożoność obliczeniową i pamięciową

include("iofuncs.jl")
include("matrixgen.jl")
using .matrixgen
using .blocksys
using .IOFuncs
using Plots

matrixSizes = [1000, 2500, 5000, 7500, 10000, 12500, 15000, 20000, 40000, 60000, 80000, 100000, 150000, 200000, 250000, 500000, 750000, 1000000]
numberOfTests = 50
blockSize = 5

function bruteforceMethod(A, b)
  return Array(A.matrix)\b
end

timesBruteforce = zeros(Float64, length(matrixSizes))
timesLU = zeros(Float64, length(matrixSizes))
timesLUOptimised = zeros(Float64, length(matrixSizes))
timesLUPivot = zeros(Float64, length(matrixSizes))
timesLUPivotOptimised = zeros(Float64, length(matrixSizes))
timesGauss = zeros(Float64, length(matrixSizes))
timesGaussOptimised = zeros(Float64, length(matrixSizes))
timesGaussPivot = zeros(Float64, length(matrixSizes))
timesGaussPivotOptimised = zeros(Float64, length(matrixSizes))

memoryBruteforce = zeros(Float64, length(matrixSizes))
memoryLU = zeros(Float64, length(matrixSizes))
memoryLUOptimised = zeros(Float64, length(matrixSizes))
memoryLUPivot = zeros(Float64, length(matrixSizes))
memoryLUPivotOptimised = zeros(Float64, length(matrixSizes))
memoryGauss = zeros(Float64, length(matrixSizes))
memoryGaussOptimised = zeros(Float64, length(matrixSizes))
memoryGaussPivot = zeros(Float64, length(matrixSizes))
memoryGaussPivotOptimised = zeros(Float64, length(matrixSizes))
memoryStructureOptimised = zeros(Float64, length(matrixSizes))
memoryStructure = zeros(Float64, length(matrixSizes))

accessBruteforce = zeros(Float64, length(matrixSizes))
accessLU = zeros(Float64, length(matrixSizes))
accessLUOptimised = zeros(Float64, length(matrixSizes))
accessLUPivot = zeros(Float64, length(matrixSizes))
accessLUPivotOptimised = zeros(Float64, length(matrixSizes))
accessGauss = zeros(Float64, length(matrixSizes))
accessGaussOptimised = zeros(Float64, length(matrixSizes))
accessGaussPivot = zeros(Float64, length(matrixSizes))
accessGaussPivotOptimised = zeros(Float64, length(matrixSizes))

setsBruteforce = zeros(Float64, length(matrixSizes))
setsLU = zeros(Float64, length(matrixSizes))
setsLUOptimised = zeros(Float64, length(matrixSizes))
setsLUPivot = zeros(Float64, length(matrixSizes))
setsLUPivotOptimised = zeros(Float64, length(matrixSizes))
setsGauss = zeros(Float64, length(matrixSizes))
setsGaussOptimised = zeros(Float64, length(matrixSizes))
setsGaussPivot = zeros(Float64, length(matrixSizes))
setsGaussPivotOptimised = zeros(Float64, length(matrixSizes))

methods = [bruteforceMethod, gaussElimination, gaussEliminationPartialPivoting, solveUsingLU!, solveUsingPartialPivotedLU!]
times = [timesBruteforce, timesGauss, timesGaussPivot, timesLU, timesLUPivot]
timesOptimised = [timesGaussOptimised, timesGaussPivotOptimised, timesLUOptimised, timesLUPivotOptimised]
mems = [memoryBruteforce, memoryGauss, memoryGaussPivot, memoryLU, memoryLUPivot]
memsOptimised = [memoryGaussOptimised, memoryGaussPivotOptimised, memoryLUOptimised, memoryLUPivotOptimised]
access = [accessBruteforce, accessGauss, accessGaussPivot, accessLU, accessLUPivot]
accessOptimised = [accessGaussOptimised, accessGaussPivotOptimised, accessLUOptimised, accessLUPivotOptimised]
sets = [setsBruteforce, setsGauss, setsGaussPivot, setsLU, setsLUPivot]
setsOptimised = [setsGaussOptimised, setsGaussPivotOptimised, setsLUOptimised, setsLUPivotOptimised]

blockmat(4, 2, 10., "complexityTestMatrix.txt")
testA = readBlockMatrix("complexityTestMatrix.txt", false)
testb = generateRightVector(testA)
for method in methods
  tempA = deepcopy(testA)
  tempb = deepcopy(testb)
  stats = @timed method(tempA, tempb)
end

println("start")

for (i, size) in enumerate(matrixSizes)
  for testNo in numberOfTests
    blockmat(size, blockSize, 10., "complexityTestMatrix.txt")
    A = readBlockMatrix("complexityTestMatrix.txt", false)
    AOptimised = readBlockMatrix("complexityTestMatrix.txt", true)
    memoryStructure[i] = Base.summarysize(A)
    memoryStructureOptimised[i] = Base.summarysize(AOptimised)
    b = generateRightVector(A)
    if(size <= 100000)
      for (index, method) in enumerate(methods)
        if (method!=bruteforceMethod || size <= 15000)
          tempA = deepcopy(A)
          tempb = deepcopy(b)
          stats = @timed method(tempA, tempb)
          times[index][i] += stats.time
          mems[index][i] += stats.bytes
          access[index][i] += tempA.elementAccessCount
          sets[index][i] += tempA.elementChangesCount
        end
      end
    end
    for (index, method) in enumerate(methods[2:end])
      tempA = deepcopy(AOptimised)
      tempb = deepcopy(b)
      stats = @timed method(tempA, tempb)
      timesOptimised[index][i] += stats.time
      memsOptimised[index][i] += stats.bytes
      accessOptimised[index][i] += tempA.elementAccessCount
      setsOptimised[index][i] += tempA.elementChangesCount
    end
  end
  for time in times
    time[i] /= numberOfTests
  end
  for time in timesOptimised
    time[i] /= numberOfTests
  end
  for mem in mems
    mem[i] /= numberOfTests
  end
  for mem in memsOptimised
    mem[i] /= numberOfTests
  end
  for a in access
    a[i] /= numberOfTests
  end
  for a in accessOptimised
    a[i] /= numberOfTests
  end
  for s in sets
    s[i] /= numberOfTests
  end
  for s in setsOptimised
    s[i] /= numberOfTests
  end
  println(size)
end

plot(
  matrixSizes[1:7],
  [timesBruteforce[1:7] timesGaussOptimised[1:7] timesGaussPivotOptimised[1:7] timesLUOptimised[1:7] timesLUPivotOptimised[1:7]],
  title="Średnia złożoność czasowa algorytmów (w sekundach)",
  legend=:topleft,
  titlefontsize=12,
  label=["Metoda bruteforce" "Gauss (opt)" "Gauss z wyborem (opt)" "LU (opt)" "LU z wyborem (opt)"]
  )
savefig("results/timesbrute.png")

plot(
  matrixSizes[1:12],
  [timesGauss[1:12] timesGaussOptimised[1:12] timesGaussPivot[1:12] timesGaussPivotOptimised[1:12]],
  title="Średnia złożoność czasowa algorytmów (w sekundach)",
  legend=:topleft,
  titlefontsize=12,
  label=["Gauss" "Gauss (opt)" "Gauss z wyborem" "Gauss z wyborem (opt)"]
)
savefig("results/timesgauss.png")

plot(
  matrixSizes[1:12],
  [timesLU[1:12] timesLUOptimised[1:12] timesLUPivot[1:12] timesLUPivotOptimised[1:12]],
  title="Średnia złożoność czasowa algorytmów (w sekundach)",
  legend=:topleft,
  titlefontsize=12,
  label=["LU" "LU (opt)" "LU z wyborem" "LU z wyborem (opt)"]
)
savefig("results/timeslu.png")

plot(
  matrixSizes,
  [timesGaussOptimised timesGaussPivotOptimised timesLUOptimised timesLUPivotOptimised],
  title="Średnia złożoność czasowa algorytmów (w sekundach)",
  legend=:topleft,
  titlefontsize=12,
  label=["Gauss (opt)" "Gauss z wyborem (opt)" "LU (opt)" "LU z wyborem (opt)"]
  )
savefig("results/timesoptimised.png")

plot(
  matrixSizes,
  [memoryStructure memoryStructureOptimised],
  title="Rozmiar struktury przechowującej macierz (w zalokowanych bajtach)",
  legend=:topleft,
  titlefontsize=10,
  label=["Wersja czasowo nieoptymalna" "Wersja czasowo optymalna"]
  )
savefig("results/memorystruct.png")

plot(
  matrixSizes[1:7],
  [memoryBruteforce[1:7] memoryGaussOptimised[1:7] memoryGaussPivotOptimised[1:7] memoryLUOptimised[1:7] memoryLUPivotOptimised[1:7]],
  title="Średnia złożoność pamięciowa algorytmów (w zalokowanych bajtach)",
  legend=:topleft,
  titlefontsize=10,
  label=["Metoda bruteforce" "Gauss (opt)" "Gauss z wyborem (opt)" "LU (opt)" "LU z wyborem (opt)"]
  )
savefig("results/memorybrute.png")


plot(
  matrixSizes,
  [memoryGaussOptimised memoryGaussPivotOptimised memoryLUOptimised memoryLUPivotOptimised],
  title="Średnia złożoność pamięciowa algorytmów (w zalokowanych bajtach)",
  legend=:topleft,
  titlefontsize=10,
  label=["Gauss (opt)" "Gauss z wyborem (opt)" "LU (opt)" "LU z wyborem (opt)"]
  )
savefig("results/memoryoptimised.png")

plot(
  matrixSizes[1:12],
  [accessGauss[1:12] accessGaussOptimised[1:12] accessGaussPivot[1:12] accessGaussPivotOptimised[1:12]],
  title="Średnia liczba operacji dostępu do elementów macierzy",
  legend=:topleft,
  titlefontsize=12,
  label=["Gauss" "Gauss (opt)" "Gauss z wyborem" "Gauss z wyborem (opt)"]
)
savefig("results/accessgauss.png")

plot(
  matrixSizes[1:12],
  [accessLU[1:12] accessLUOptimised[1:12] accessLUPivot[1:12] accessLUPivotOptimised[1:12]],
  title="Średnia liczba operacji dostępu do elementów macierzy",
  legend=:topleft,
  titlefontsize=12,
  label=["LU" "LU (opt)" "LU z wyborem" "LU z wyborem (opt)"]
)
savefig("results/accesslu.png")

plot(
  matrixSizes,
  [accessGaussOptimised accessGaussPivotOptimised accessLUOptimised accessLUPivotOptimised],
  title="Średnia liczba operacji dostępu do elementów macierzy",
  legend=:topleft,
  titlefontsize=12,
  label=["Gauss (opt)" "Gauss z wyborem (opt)" "LU (opt)" "LU z wyborem (opt)"]
  )
savefig("results/accessoptimised.png")

plot(
  matrixSizes[1:12],
  [setsGauss[1:12] setsGaussOptimised[1:12] setsGaussPivot[1:12] setsGaussPivotOptimised[1:12]],
  title="Średnia liczba modyfikacji elementów macierzy",
  titlefontsize=12,
  legend=:topleft,
  label=["Gauss" "Gauss (opt)" "Gauss z wyborem" "Gauss z wyborem (opt)"]
)
savefig("results/setsgauss.png")

plot(
  matrixSizes[1:12],
  [setsLU[1:12] setsLUOptimised[1:12] setsLUPivot[1:12] setsLUPivotOptimised[1:12]],
  title="Średnia liczba modyfikacji elementów macierzy",
  legend=:topleft,
  titlefontsize=12,
  label=["LU" "LU (opt)" "LU z wyborem" "LU z wyborem (opt)"]
)
savefig("results/setslu.png")

plot(
  matrixSizes,
  [setsGaussOptimised setsGaussPivotOptimised setsLUOptimised setsLUPivotOptimised],
  title="Średnia liczba modyfikacji elementów macierzy",
  legend=:topleft,
  titlefontsize=12,
  label=["Gauss (opt)" "Gauss z wyborem (opt)" "LU (opt)" "LU z wyborem (opt)"]
  )
savefig("results/setsoptimised.png")