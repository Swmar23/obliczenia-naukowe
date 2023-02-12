# Marek Świergoń 261750 Obliczenia Naukowe
# Lista 3 Zadanie 6

include("metody_iteracyjne.jl")
using .MetodyIteracyjne

function f1(x::Float64)::Float64
  return exp(1-x) - 1
end

function pf1(x::Float64)::Float64
  return -exp(1-x)
end

function f2(x::Float64)::Float64
  return x*exp(-x)
end

function pf2(x::Float64)::Float64
  return (x-1) * (-exp(-x))
end

delta::Float64 = 10^(-5)
epsilon::Float64 = 10^(-5)
maxit = 200

println("Metoda bisekcji dla [0,2] i f1: ", mbisekcji(f1, 0.0, 2.0, delta, epsilon))
println("Metoda bisekcji dla [0,3] i f1: ", mbisekcji(f1, 0.0, 3.0, delta, epsilon))
println("Metoda bisekcji dla [-10^6,10^6] i f1: ", mbisekcji(f1, -1000000.0, 1000000.0, delta, epsilon))
println("Metoda Newtona dla -1000.0 i f1: ", mstycznych(f1, pf1, -1000.0, delta, epsilon, maxit))
println("Metoda Newtona dla -100.0 i f1: ", mstycznych(f1, pf1, -100.0, delta, epsilon, maxit))
println("Metoda Newtona dla -1.0 i f1: ", mstycznych(f1, pf1, -1.0, delta, epsilon, maxit))
println("Metoda Newtona dla 0.0 i f1: ", mstycznych(f1, pf1, 0.0, delta, epsilon, maxit))
println("Metoda Newtona dla 0.9 i f1: ", mstycznych(f1, pf1, 0.9, delta, epsilon, maxit))
println("Metoda Newtona dla 1.0 i f1: ", mstycznych(f1, pf1, 1.0, delta, epsilon, maxit))
println("Metoda Newtona dla 1.1 i f1: ", mstycznych(f1, pf1, 1.1, delta, epsilon, maxit))
println("Metoda Newtona dla 2.0 i f1: ", mstycznych(f1, pf1, 2.0, delta, epsilon, maxit))
println("Metoda Newtona dla 4.0 i f1: ", mstycznych(f1, pf1, 4.0, delta, epsilon, maxit))
println("Metoda Newtona dla 8.0 i f1: ", mstycznych(f1, pf1, 8.0, delta, epsilon, maxit))
println("Metoda Newtona dla 10000.0 i f1: ", mstycznych(f1, pf1, 10000.0, delta, epsilon, maxit))
println("Metoda siecznych dla 0.0, 0.5 i f1: ", msiecznych(f1, 0.0, 0.5, delta, epsilon, maxit))
println("Metoda siecznych dla 0.0, 2.0 i f1: ", msiecznych(f1, 0.0, 2.0, delta, epsilon, maxit))
println("Metoda siecznych dla -100.0, 100.0 i f1: ", msiecznych(f1, -100.0, 100.0, delta, epsilon, maxit))
println("Metoda siecznych dla 0.9, 20000 i f1: ", msiecznych(f1, 0.9, 20000.0, delta, epsilon, maxit))
println("Metoda siecznych dla 10000.0, 10000.5 i f1: ", msiecznych(f1, 10000.0, 10000.5, delta, epsilon, maxit))
println("Metoda siecznych dla -100.0, -99.5 i f1: ", msiecznych(f1, -100.0, -99.5, delta, epsilon, maxit))



println("Metoda bisekcji dla [-1,1] i f2: ", mbisekcji(f2, -1.0, 1.0, delta, epsilon))
println("Metoda bisekcji dla [-1,2] i f2: ", mbisekcji(f2, -1.0, 2.0, delta, epsilon))
println("Metoda bisekcji dla [-0.1,30] i f2: ", mbisekcji(f2, -0.1, 30.0, delta, epsilon))
println("Metoda bisekcji dla [-10^6,0.01] i f2: ", mbisekcji(f2, -1000000.0, 0.01, delta, epsilon))
println("Metoda bisekcji dla [-10^6,10^8] i f2: ", mbisekcji(f2, -1000000.0, 100000000.0, delta, epsilon))

println("Metoda Newtona dla -1000.0 i f2: ", mstycznych(f2, pf2, -1000.0, delta, epsilon, maxit))
println("Metoda Newtona dla -100.0 i f2: ", mstycznych(f2, pf2, -100.0, delta, epsilon, maxit))
println("Metoda Newtona dla -1.0 i f2: ", mstycznych(f2, pf2, -1.0, delta, epsilon, maxit))
println("Metoda Newtona dla -0.1 i f2: ", mstycznych(f2, pf2, -0.1, delta, epsilon, maxit))
println("Metoda Newtona dla 0.0 i f2: ", mstycznych(f2, pf2, 0.0, delta, epsilon, maxit))
println("Metoda Newtona dla 0.1 i f2: ", mstycznych(f2, pf2, 0.1, delta, epsilon, maxit))
println("Metoda Newtona dla 0.9 i f2: ", mstycznych(f2, pf2, 0.9, delta, epsilon, maxit))
println("Metoda Newtona dla 1.0 i f2: ", mstycznych(f2, pf2, 1.0, delta, epsilon, maxit))
println("Metoda Newtona dla 2.0 i f2: ", mstycznych(f2, pf2, 2.0, delta, epsilon, maxit))
println("Metoda Newtona dla 4.0 i f2: ", mstycznych(f2, pf2, 4.0, delta, epsilon, maxit))
println("Metoda Newtona dla 8.0 i f2: ", mstycznych(f2, pf2, 8.0, delta, epsilon, maxit))
println("Metoda Newtona dla 1000.0 i f2: ", mstycznych(f2, pf2, 1000.0, delta, epsilon, maxit))

println("Metoda siecznych dla -1.0, -0.5 i f2: ", msiecznych(f2, -1.0, -0.5, delta, epsilon, maxit))
println("Metoda siecznych dla 1.0, 0.5 i f2: ", msiecznych(f2, 1.0, 0.5, delta, epsilon, maxit))
println("Metoda siecznych dla 0.0, 2.0 i f2: ", msiecznych(f2, 0.0, 2.0, delta, epsilon, maxit))
println("Metoda siecznych dla -0.9, 20000 i f2: ", msiecznych(f2, -0.9, 20000.0, delta, epsilon, maxit))
println("Metoda siecznych dla -200.0, -199.5 i f2: ", msiecznych(f2, -200.0, -199.5, delta, epsilon, maxit))
println("Metoda siecznych dla -10000.0, -0.5 i f2: ", msiecznych(f2, -10000.0, -0.5, delta, epsilon, maxit))

