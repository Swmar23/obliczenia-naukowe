# Marek Świergoń 261750 Obliczenia Naukowe Lista 5
# Program testujący jakość rozwiązań

include("iofuncs.jl")
include("matrixgen.jl")
using .matrixgen
using .blocksys
using LinearAlgebra
using Statistics
using .IOFuncs

matrixSizes = [50, 100, 1000, 10000, 100000, 1000000]
numberOfTests = 100
blockSizes = [2, 5, 10]


for size in matrixSizes
  for blockSize in blockSizes
    errorsGauss = zeros(Float64, numberOfTests)
    errorsGaussPivot = zeros(Float64, numberOfTests)
    errorsLU = zeros(Float64, numberOfTests)
    errorsLUPivot = zeros(Float64, numberOfTests)
    for testNo in 1:numberOfTests
      targetSolution = ones(Float64, size)
      blockmat(size, blockSize, 10., "qualityTestMatrix.txt")
      A = readBlockMatrix("qualityTestMatrix.txt", true)
      b = generateRightVector(A)
      tempA = deepcopy(A)
      tempb = deepcopy(b)
      solutionGauss = gaussElimination(tempA, tempb)
      tempA = deepcopy(A)
      tempb = deepcopy(b)
      solutionGaussPivot = gaussEliminationPartialPivoting(tempA, tempb)
      tempA = deepcopy(A)
      tempb = deepcopy(b)
      solutionLU = solveUsingLU!(tempA, tempb)
      tempA = deepcopy(A)
      tempb = deepcopy(b)
      solutionLUPivot = solveUsingPartialPivotedLU!(tempA, tempb)
      errorGauss = norm(solutionGauss - targetSolution) / norm(targetSolution)
      errorGaussPivot = norm(solutionGaussPivot - targetSolution) / norm(targetSolution)
      errorLU = norm(solutionLU - targetSolution) / norm(targetSolution)
      errorLUPivot = norm(solutionLUPivot - targetSolution) / norm(targetSolution)
      errorsGauss[testNo] = errorGauss
      errorsGaussPivot[testNo] = errorGaussPivot
      errorsLU[testNo] = errorLU
      errorsLUPivot[testNo] = errorLUPivot
    end
    println(rpad(size, 10), " & ", rpad(blockSize, 5), " & ", rpad(mean(errorsGauss), 25), " & ", rpad(mean(errorsGaussPivot), 25),
    " & ", rpad(mean(errorsLU), 25), " & ", rpad(mean(errorsLUPivot), 25), " \\\\\\hline")
  end
end