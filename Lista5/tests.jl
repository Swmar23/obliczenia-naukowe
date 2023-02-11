# Marek Świergoń 261750 Obliczenia Naukowe Lista 5
# Plik z testami 

include("iofuncs.jl")
include("matrixgen.jl")
using .matrixgen
using .blocksys
using .IOFuncs
using Test

blockmat(5000, 5, 10., "testMatrix1.txt")
A = readBlockMatrix("testMatrix1.txt", true)
x = ones(Float64, A.size)
b = generateRightVector(A)

@testset "$(rpad("Rozwiązanie Gaussem - wektor jedynek", 70))" begin
  @test isapprox(gaussElimination(deepcopy(A), deepcopy(b)), x)
end

@testset "$(rpad("Rozwiązanie Gaussem z częściowym wyborem - wektor jedynek", 70))" begin
  @test isapprox(gaussEliminationPartialPivoting(deepcopy(A), deepcopy(b)), x)
end

@testset "$(rpad("Rozwiązanie rozkładem LU - wektor jedynek", 70))" begin
  @test isapprox(solveUsingLU!(deepcopy(A), deepcopy(b)), x)
end

@testset "$(rpad("Rozwiązanie rozkładem LU z częściowym wyborem - wektor jedynek", 70))" begin
  @test isapprox(solveUsingPartialPivotedLU!(deepcopy(A), deepcopy(b)), x)
end

blockmat(2000, 4, 10., "testMatrix2.txt")
A = readBlockMatrix("testMatrix2.txt", true)
b = rand(Float64, A.size)

@testset "$(rpad("Rozwiązanie Gaussem - losowy wektor b", 70))" begin
  @test isapprox(A * gaussElimination(deepcopy(A), deepcopy(b)), b)
end

@testset "$(rpad("Rozwiązanie Gaussem z częściowym wyborem - losowy wektor b", 70))" begin
  @test isapprox(A * gaussEliminationPartialPivoting(deepcopy(A), deepcopy(b)), b)
end

@testset "$(rpad("Rozwiązanie rozkładem LU - losowy wektor b", 70))" begin
  @test isapprox(A * solveUsingLU!(deepcopy(A), deepcopy(b)), b)
end

@testset "$(rpad("Rozwiązanie rozkładem LU z częściowym wyborem - losowy wektor b", 70))" begin
  @test isapprox(A * solveUsingPartialPivotedLU!(deepcopy(A), deepcopy(b)), b)
end