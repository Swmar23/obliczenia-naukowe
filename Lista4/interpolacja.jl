# Marek Świergoń 261750 Obliczenia Naukowe Lista 4 Zadania 1 - 4

module Interpolacja
export ilorazyRoznicowe, warNewton, naturalna, rysujNnfx
using Plots

"""
Funkcja obliczająca ilorazy różnicowe będące współczynnikami kombinacji liniowej dla postaci Newtona
wzoru interpolacyjnego.

Dane:
  x – wektor długości n + 1 zawierający węzły x_0, ..., x_n: x[1] = x_0, ..., x[n+1] = x_n
  f – wektor długości n + 1 zawierający wartości interpolowanej funkcji w węzłach: f(x_0), ..., f(x_n)

Wyniki:
  fx – wektor długości n + 1 zawierający obliczone ilorazy różnicowe:
    fx[1] = f[x_0], fx[2] = f[x_0, x_1], ..., fx[n] = f[x_0, ..., x{n-1}], fx[n+1] = f[x_0, ..., x_n].
"""
function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})::Vector{Float64}
  len = length(x)
  fx = zeros(len)

  for i in 1:len   # umieszczam wartości funkcji do tablicy wynikowej, f(x_0) = f[x_0]
    fx[i] = f[i]
  end

  for j in 2:len  # wyliczam f[x_0, x_1, ..., x_j]
    for k in len:-1:j
      fx[k] = (fx[k] - fx[k-1]) / (x[k] - x[k-j+1])
    end
  end

  return fx
end


"""
Funkcja obliczająca wartość wielomianu interpolacyjnego stopnia n w postaci Newtona w punkcie x = t.

Dane:
  x – wektor długości n + 1 zawierający węzły x_0, ..., x_n: x[1] = x_0 ,..., x[n+1] = x_n
  fx – wektor długości n + 1 zawierający ilorazy różnicowe: 
    fx[1] = f[x_0], fx[2] = f[x_0, x_1], ..., fx[n] = f[x_0, ..., x_{n-1}], fx[n+1] = f[x_0, ..., x_n]
  t – punkt, w którym należy obliczyć wartość wielomianu

Wyniki:
  nt – wartość wielomianu w punkcie t.
"""
function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)::Float64
  len = length(x)
  nt::Float64 = fx[len]

  for i in (len-1):-1:1
    nt = fx[i] + (t - x[i])*nt
  end

  return nt
end


"""
Funkcja obliczająca współczynniki wielomianu interpolacyjnego w postaci naturalnej dla wielomianu
zadanego w postaci Newtona.

Dane:
  x – wektor długości n + 1 zawierający węzły x_0, ..., x_n: x[1] = x_0 ,..., x[n+1] = x_n
  fx – wektor długości n + 1 zawierający ilorazy różnicowe: 
    fx[1] = f[x_0], fx[2] = f[x_0, x_1], ..., fx[n] = f[x_0, ..., x_{n-1}], fx[n+1] = f[x_0, ..., x_n]

Wyniki:
  a – wektor długości n + 1 zawierający obliczone współczynniki postaci naturalnej:
    a[1] = a_0, a[2] = a_1, ..., a[n] = a_{n-1}, a[n+1] = a_n.
"""
function naturalna(x::Vector{Float64}, fx::Vector{Float64})::Vector{Float64}
  len = length(x)
  a::Vector{Float64} = zeros(len)
  a[len] = fx[len]
  for i in (len-1):-1:1
    a[i] = fx[i] - x[i] * a[i+1]
    for j in (i+1):(len-1)
      a[j] += -x[i] * a[j+1]
    end
  end

  return a
end

"""
Funkcja interpolująca zadaną funkcję f(x) w przedziale [a, b] za pomocą wielomianu interpolacyjnego
stopnia n w postaci Newtona. Rysuje wielomian interpolacyjny i interpolowaną funkcję z użyciem pakietu Plots.
Do interpolacji stosuje węzłów równoodległych.

Dane:
  f – funkcja f(x) zadana jako anonimowa funkcja,
  a,b – krańce przedziału interpolacji
  n – stopień wielomianu interpolacyjnego

Wyniki:
  funkcja rysuje wielomian interpolacyjny i interpolowaną funkcję w przedziale [a, b].
"""
function rysujNnfx(f, a::Float64, b::Float64, n::Int)
  rozdzielczosc = 100  # liczba punktów rysowana na wykresie między węzłami (wliczając węzeł z lewej strony przedziału)
  h::Float64 = (b - a) / n
  x::Vector{Float64} = zeros(n+1)
  fWartosci::Vector{Float64} = zeros(n+1)
  for i in 1:(n+1)
    x[i] = a + (i-1)*h
    fWartosci[i] = f(x[i])
  end

  c::Vector{Float64} = ilorazyRoznicowe(x, fWartosci)

  liczbaPunktow = rozdzielczosc * n + 1 # plus jeden bo jeszcze uwzgledniamy kraniec b
  odstep::Float64 = (b - a) / (liczbaPunktow - 1)

  xWykres::Vector{Float64} = zeros(liczbaPunktow)
  fWykres::Vector{Float64} = zeros(liczbaPunktow)
  wielomianWykres::Vector{Float64} = zeros(liczbaPunktow)

  xWykres[1] = a
  fWykres[1] = fWartosci[1]
  wielomianWykres[1] = fWartosci[1] # a jest jednym z n+1 węzłów
  for i in 2:liczbaPunktow
    xWykres[i] = a + (i-1)*odstep
    fWykres[i] = f(xWykres[i])
    wielomianWykres[i] = warNewton(x, c, xWykres[i])
  end

  p = plot(xWykres, [fWykres, wielomianWykres], label = ["funkcja" "wielomian"], title = "Interpolacja funkcji f wielomianem stopnia <=$n")
  # display(p)
  return p
end

end