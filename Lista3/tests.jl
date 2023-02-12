# Marek Świergoń 261750 Obliczenia Naukowe
# testy do metod iteracyjnych z zadań 1-3

include("metody_iteracyjne.jl")
using .MetodyIteracyjne
using Test

epsilon = delta = 10^(-5)

@testset "$(rpad("Metoda bisekcji", 15))" begin
  # podstawowy przykład funkcji
  f = x -> 2*x^2 - x
  poprawnyWynik = 0.5
  res = mbisekcji(f, 0.1, 1.0, delta, epsilon)
  x = res[1]
  fx = res[2]
  err = res[4]
  @test abs(fx) <= epsilon
  @test abs(poprawnyWynik-x) <= delta
  @test res[4] == 0

  # ta sama funkcja, ale na przedziale bez zmiany znaku
  res = mbisekcji(f, 0.7, 1.0, delta, epsilon)
  x = res[1]
  fx = res[2]
  it = res[3]
  err = res[4]
  @test fx == Nothing
  @test x == Nothing
  @test it == Nothing
  @test err == 1

  # ta sama funkcja, ale pierwiatek równo w połowie przedziału
  res = mbisekcji(f, 0.0, 1.0, delta, epsilon)
  x = res[1]
  fx = res[2]
  it = res[3]
  err = res[4]
  @test fx == 0
  @test x == 0.5
  @test it == 1
  @test err == 0
end

@testset "$(rpad("Metoda Newtona", 15))" begin
  # podstawowy przykład funkcji dobry dla tej metody
  f = x -> x^3 - 1
  pf = x -> 3*x^2
  poprawnyWynik = 1.0
  res = mstycznych(f, pf, 0.5, delta, epsilon, 10)
  x = res[1]
  fx = res[2]
  err = res[4]
  @test abs(fx) < epsilon
  @test abs(poprawnyWynik-x) < delta
  @test err == 0

  # gorszy przykład, w punkcie gdzie pochodna równa zero dla
  # przybliżenia początkowego
  f = x -> 2*x^2 - x
  pf = x -> 4*x - 1
  res = mstycznych(f, pf, 0.25, delta, epsilon, 10)
  err = res[4]
  @test err == 2

  # dla tego przykładu metoda Newtona wpadnie w cykl
  f = x -> x^3 - 2*x + 2
  pf = x -> 3*x^2 - 2
  res = mstycznych(f, pf, 0.0, delta, epsilon, 51)
  x = res[1]
  fx = res[2]
  it = res[3]
  err = res[4]
  @test abs(fx) > epsilon
  @test abs(x-0) > delta
  @test it == 51
  @test err == 1
end

@testset "$(rpad("Metoda siecznych", 15))" begin
  # podstawowy przykład funkcji dobry dla tej metody
  f = x -> x^3 - 1
  poprawnyWynik = 1.0
  res = msiecznych(f, 0.5, 0.7, delta, epsilon, 10)
  x = res[1]
  fx = res[2]
  err = res[4]
  @test abs(fx) < epsilon
  @test abs(poprawnyWynik-x) < delta
  @test err == 0

  # funkcja która ma pochodną równą zero w miejscu zerowym
  f = x -> x^2
  res = msiecznych(f, -1.0, 1.0, delta, epsilon, 50)
  x = res[1]
  fx = res[2]
  it = res[3]
  err = res[4]
  @test isnan(fx)
  @test isnan(x)
  @test it == 50
  @test err == 1
end