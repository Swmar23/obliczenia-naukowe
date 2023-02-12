# Marek Świergoń 261750 Obliczenia Naukowe
# implementacja metod iteracyjnych na potrzeby Listy 3 (zadania 1-3)

module MetodyIteracyjne
export mbisekcji, mstycznych, msiecznych


"""
Funkcja znajdująca miejsce zerowe funkcji f z użyciem metody bisekcji.
Warunek działania - funkcja f zmienia znak w przedziale [a,b]

Input:
f - funkcja f(x::Float64)::Float64 dla której szukamy pierwiastka
a, b - końce przedziału początkowego [a,b]
delta - dokładność obliczeń bazująca na długości przedziału [a_n, b_n]
epsilon - dokładność obliczeń bazująca na maksymalnym dopuszczalnym
          odchyleniu wartości f(r) od 0 dla pierwiastka r

Output:
r - przybliżenie szukanego miejsca zerowego funkcji f
v - wartość f(r),
it - liczba wykonanych iteracji
err - sygnalizacja błędu:
      0 - brak błędu,
      1 - funkcja nie zmienia znaku w przedziale [a,b]

Implementacja inspirowana pseudokodem algorytmu z książki
Analiza Numeryczna, Kincaid, Cheney
"""
function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
  fa::Float64 = f(a)
  fb::Float64 = f(b)
  e::Float64 = b - a
  if sign(fa) == sign(fb)
    return Nothing, Nothing, Nothing, 1
  end

  it = 1
  r::Float64 = a+e
  v::Float64 = f(r)

  while true
    e /= 2
    r = a+e
    v = f(r)
    if abs(e) < delta || abs(v) < epsilon
      return r, v, it, 0
    end
    if sign(v) != sign(fa)
      b = r
      fb = v
    else
      a = r
      fa = v
    end 
    it += 1
  end
end


"""
Funkcja znajdująca miejsce zerowe funkcji f z użyciem metody Newtona (stycznych).
Warunek działania - pochodna pf nie jest równa (bliska) zeru

Input:
f - funkcja f(x::Float64)::Float64 dla której szukamy pierwiastka
pf - pochodna funkcji f, pf(x::Float64)::Float64
x0 - przybliżenie początkowe miejsca zerowego
delta - dokładność obliczeń bazująca na odległości kolejnych przybliżeń
        miejsca zerowego
epsilon - dokładność obliczeń bazująca na maksymalnym dopuszczalnym
          odchyleniu wartości f(r) od 0 dla pierwiastka r
maxit - maksymalna dopuszczalna liczba iteracji

Output:
r - przybliżenie szukanego miejsca zerowego funkcji f
v - wartość f(r),
it - liczba wykonanych iteracji
err - sygnalizacja błędu:
      0 - brak błędu,
      1 - nie osiągnięto wymaganej dokładności w maxit iteracji
      2 - pochodna funkcji f bliska zeru

Implementacja inspirowana pseudokodem algorytmu z książki
Analiza Numeryczna, Kincaid, Cheney
"""
function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
  v::Float64 = f(x0)

  if abs(v) < epsilon
    return x0, v, 0, 0
  end

  for it in 1:maxit
    pfx0::Float64 = pf(x0)
    if abs(pfx0) < eps(Float64)
      return x0, v, it, 2
    end
    x1::Float64 = x0 - (v / pfx0)
    v = f(x1)
    if abs(x1 - x0) < delta || abs(v) < epsilon
      return x1, v, it, 0
    end
    x0 = x1
  end

  return x0, v, maxit, 1
end


"""
Funkcja znajdująca miejsce zerowe funkcji f z użyciem metody siecznych.

Input:
f - funkcja f(x::Float64)::Float64 dla której szukamy pierwiastka
x0,x1 - kolejne przybliżenia początkowe miejsca zerowego
delta - dokładność obliczeń bazująca na odległości kolejnych przybliżeń
        miejsca zerowego
epsilon - dokładność obliczeń bazująca na maksymalnym dopuszczalnym
          odchyleniu wartości f(r) od 0 dla pierwiastka r
maxit - maksymalna dopuszczalna liczba iteracji

Output:
r - przybliżenie szukanego miejsca zerowego funkcji f
v - wartość f(r),
it - liczba wykonanych iteracji
err - sygnalizacja błędu:
      0 - brak błędu,
      1 - nie osiągnięto wymaganej dokładności w maxit iteracji

Implementacja inspirowana pseudokodem algorytmu z książki
Analiza Numeryczna, Kincaid, Cheney
"""
function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
  fx0::Float64 = f(x0)
  fx1::Float64 = f(x1) #bliższe przybliżenie!

  for it in 1:maxit
    if abs(fx1) > abs(fx0)
      x0, x1 = x1, x0     #swap (x0, x1)
      fx0, fx1 = fx1, fx0 #swap (fx0, fx1)
    end
    s::Float64 = (x0 - x1) / (fx0 - fx1) 
    x0 = x1
    fx0 = fx1
    x1 = x1 - fx1 * s
    fx1 = f(x1)
    if abs(x0 - x1) < delta || abs(fx1) < epsilon
      return x1, fx1, it, 0
    end
  end

  return x1, fx1, maxit, 1    
end

end