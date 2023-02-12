# Marek Świergoń 261750 Obliczenia Naukowe
# Lista 3 Zadanie 5

include("metody_iteracyjne.jl")
using .MetodyIteracyjne

# Chcemy wyznaczyć x, dla którego wykresy funkcji y = 3x i y = e^x
# się przecinają. Innymi słowy szukamy miejsc zerowych funkcji
# f(x) = e^x - 3x. Dla każdego pierwiastka potrzebuję a i b 
# t.że sgn(f(a))!=sgn(f(b))

function f(x::Float64)::Float64
  return exp(x) - 3*x
end

delta::Float64 = 10^(-4)
epsilon::Float64 = 10^(-4)

# Zauważam, że będą dwa miejsca zerowe, co częściowo wynika z 
# analizy pochodnej pf(x) = e^x - 3 (f najpierw maleje, przecina OX,
# potem zaczyna rosnąć i ponownie przecina OX)

# Pierwiastek 1.
# dla a = 0.5 f(a) = approx. 0.15, dla b = 1 f(b) = approx. -0.28
# czyli na przedziale [a,b] funkcja zmienia znak
println("r_1 (pierwszy pierwiastek): ", mbisekcji(f, 0.5, 1.0, delta, epsilon))

# Pierwiastek 2.
# dla a = 1 f(a) = approx. -0.28, dla b = 2 f(b) = approx. 1.39
# czyli na przedziale [a,b] funkcja zmienia znak
println("r_2 (drugi pierwiastek): ", mbisekcji(f, 1.0, 2.0, delta, epsilon))