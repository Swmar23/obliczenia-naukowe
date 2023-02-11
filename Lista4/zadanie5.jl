# Marek Świergoń 261750 Obliczenia Naukowe Lista 4 Zadanie 5

include("interpolacja.jl")
using .Interpolacja
using Plots

f = x -> exp(x)
g = x -> x^2 * sin(x)

for n in [1, 2, 3, 4, 5, 10, 15]
  plot_f = rysujNnfx(f, 0.0, 1.0, n)
  plot_g = rysujNnfx(g, -1.0, 1.0, n)
  savefig(plot_f, "./wykresy/zadanie5_f1_$n.png")
  savefig(plot_g, "./wykresy/zadanie5_f2_$n.png")
end