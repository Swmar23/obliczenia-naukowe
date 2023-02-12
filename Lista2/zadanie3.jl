#Marek Świergoń 261750 Obliczenia Naukowe Lista 2 zadanie 3

using LinearAlgebra
using Printf

function hilb(n::Int)
# Function generates the Hilbert matrix  A of size n,
#  A (i, j) = 1 / (i + j - 1)
# Inputs:
#	n: size of matrix A, n>=1
#
#
# Usage: hilb(10)
#
# Pawel Zielinski
  if n < 1
    error("size n should be >= 1")
  end
  return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end

function matcond(n::Int, c::Float64)
# Function generates a random square matrix A of size n with
# a given condition number c.
# Inputs:
#	n: size of matrix A, n>1
#	c: condition of matrix A, c>= 1.0
#
# Usage: matcond(10, 100.0)
#
# Pawel Zielinski
  if n < 2
    error("size n should be > 1")
  end
  if c< 1.0
    error("condition number  c of a matrix  should be >= 1.0")
  end
  (U,S,V)=svd(rand(n,n))
  return U*diagm(0 =>[LinRange(1.0,c,n);])*V'
end

# Metoda rozwiązuje dwoma metodami układ równań liniowych dla macierzy Hilberta rozmiarów od 1 do n,
# wyświetla rozmiar, wskaźnik uwarunkowania i błędy względne metod
function hilbertMatricesErrors(n::Int)
  if n < 1
    error("n has to be >= 1")
  end
  println("**********************************")
  println("Hilbert's matrices")
  println("**********************************")
  for i in 1:n
    A = hilb(i)
    xExact = ones(Float64, i)
    b = A * xExact

    xWithGauss = A \ b 
    xWithInverse = inv(A) * b

    relativeErrorWithGauss = norm(xWithGauss - xExact) / norm(xExact)
    relativeErrorWithInverse = norm(xWithInverse - xExact) / norm(xExact)
    println("----------------")
    @printf("Size: %d x %d | Condition number: %e | Rank number: %d \n", i, i, cond(A), rank(A));
    @printf("Relative error for Gauss' method: %e | Relative error for inverse method: %e\n", relativeErrorWithGauss, relativeErrorWithInverse)
    println("----------------")
  end
  println("\n\n")
end

# Metoda rozwiązuje dwoma metodami układ równań liniowych dla macierzy losowych
# o rozmiarach zadanych w tablicy n i wskaźniku uwarunkowania zadanym w tablicy c.
# Wyświetla rozmiar, wskaźnik uwarunkowania i błędy względne metod
function randomMatricesErrors(n::Array{Int}, c::Array{Float64})
  println("**********************************")
  println("Random matrices")
  println("**********************************")
  for i in n
    for j in c
      A = matcond(i,j)
      xExact = ones(Float64, i)
      b = A * xExact

      xWithGauss = A \ b 
      xWithInverse = inv(A) * b

      relativeErrorWithGauss = norm(xWithGauss - xExact) / norm(xExact)
      relativeErrorWithInverse = norm(xWithInverse - xExact) / norm(xExact)
      println("----------------")
      @printf("Size: %d x %d | Condition number: %e | Rank number: %d \n", i, i, j, rank(A));
      @printf("Relative error for Gauss' method: %e | Relative error for inverse method: %e\n", relativeErrorWithGauss, relativeErrorWithInverse)
      println("----------------")

    end
  end
  println("\n\n")
end

hilbertMatricesErrors(20)
global sizes = [5,10,20]
global conditionNumbers = [Float64(1), Float64(10), Float64(10^3), Float64(10^7), Float64(10^12), Float64(10^16)]
randomMatricesErrors(sizes, conditionNumbers)

