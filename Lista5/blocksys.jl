# Marek Świergoń 261750 Obliczenia Naukowe Lista 5
# Plik z modułem z metodami potrzebnymi do zadania

include("blockmatrix.jl")

module blocksys
export generateRightVector,
       gaussElimination, gaussEliminationPartialPivoting,
       generateLU!, solveGivenLU!, solveUsingLU!,
       generateLUPartialPivoting!,
       solveUsingPartialPivotedLU!,
       solveGivenPartialPivotedLU!
using Main.myBlockMatrix


"""
Funkcja wyliczająca wektor prawych stron przy założeniu, że wektor rozwiązania
składa się z samych jedynek.

Dane
A - macierz blokowa postaci zgodnej z listą zadań, rozmiaru nxn, silnie diagonalna

Zwraca wektor prawych stron długości n
"""
function generateRightVector(A::BlockMatrix)
  b = zeros(Float64, A.size)
  for i in 1:A.size
    for j in firstColumn(A, i):lastColumn(A, i)
      b[i] += A[i, j]
    end
  end
  return b
end


"""
Funkcja rozwiązująca układ równań postaci Ax=b metodą eliminacji Gaussa bez wyboru.

Dane
A - macierz blokowa postaci zgodnej z listą zadań, rozmiaru nxn, silnie diagonalna

b - wektor prawych stron długości n

Zwraca wektor rozwiązania długości n
"""
function gaussElimination(A::BlockMatrix, b::Vector{Float64})
  n = A.size
  # etap I - doprowadzenie A do macierzy górnotrójkątnej
  for column in 1: n-1
    for i in column+1 : lastRow(A, column)
      try
        l = A[i, column] / A[column, column] # współczynnik, z pomocą którego zerujemy
        # A[i, column] = 0.0 (nie ma potrzeby zerować)

        for j in column+1 : lastColumn(A, column) #odejmujemy od pozostałych elementów w wierszu
          A[i, j] -= l * A[column, j]
        end

        b[i] -= l * b[column] # aktualizacja wektora prawych stron

      catch err
        error("Wartość zbyt bliska zeru wystąpiła na przekątnej macierzy A ($k, $k)")

      end
    end
  end

  #etap II - rozwiązanie układu z macierzą górnotrójkątną
  solution = zeros(Float64, n)
  solution[n] = b[n] / A[n, n]
  for i in n-1: -1: 1
    currentResult = b[i]
    for j in i+1 : lastColumn(A, i)
      currentResult -= A[i, j] * solution[j]
    end
    currentResult /= A[i, i]
    solution[i] = currentResult
  end
  return solution
 
end


"""
Funkcja rozwiązująca układ równań postaci Ax=b metodą eliminacji Gaussa z częściowym wyborem.

Dane
A - macierz blokowa postaci zgodnej z listą zadań, rozmiaru nxn, silnie diagonalna

b - wektor prawych stron długości n

Zwraca wektor rozwiązania długości n
"""
function gaussEliminationPartialPivoting(A::BlockMatrix, b::Vector{Float64})
  n = A.size
  p = [1:n;] # tablica do przechowywania permutacji wykonanych przy wyborze pivota

  # etap I - doprowadzenie A do macierzy górnotrójkątnej
  for column in 1: n-1
    maxElem = 0
    maxIndex = column
    for k in column : lastRow(A, column) # znalezienie pivota
      if abs(A[p[k], column]) > abs(maxElem)
        maxElem = A[p[k], column]
        maxIndex = k
      end
    end
    p[column], p[maxIndex] = p[maxIndex], p[column] # swap uwzględniony w tablicy permutacji
    for i in column+1 : lastRow(A, column)
      try
        l = A[p[i], column] / A[p[column], column] # współczynnik, z pomocą którego zerujemy
        # A[p[i], column] = 0.0 (nie ma potrzeby zerować)

        for j in column+1 : lastColumn(A, column + A.blockSize) #odejmujemy od pozostałych elementów w wierszu
          A[p[i], j] -= l * A[p[column], j]
        end

        b[p[i]] -= l * b[p[column]] # aktualizacja wektora prawych stron

      catch err
        error("Wartość zbyt bliska zeru wystąpiła na przekątnej macierzy A ($k, $k)")

      end
    end
  end

  #etap II - rozwiązanie układu z macierzą górnotrójkątną (uwzględniając permutacje)
  solution = zeros(n)
  solution[n] = b[p[n]] / A[p[n], n]
  for i in n-1: -1: 1
    solution[i] = b[p[i]]
    for j in i+1 : lastColumn(A, i + A.blockSize)
      solution[i] -= A[p[i], j] * solution[j]
    end
    solution[i] /= A[p[i], i]
  end
  return solution
end


"""
Funkcja generująca bez wyboru rozkład LU dla zadanej macierzy A. Funkcja operuje na macierzy A, 
modyfikuje ją aż do utworzenia z niej LU.

Dane:
A - macierz blokowa postaci zgodnej z listą zadań, rozmiaru nxn, silnie diagonalna
"""
function generateLU!(A::BlockMatrix)
  n = A.size

  for column in 1:(n-1)
    for i in (column+1):lastRow(A, column)
      try
        l = A[i, column] / A[column, column] # współczynnik, z pomocą którego zerujemy
        A[i, column] = l # w wyzerowanym polu wstawiamy właśnie ten współczynnik

        for j in column+1 : lastColumn(A, column) #odejmujemy od pozostałych elementów w wierszu
          A[i, j] -= l * A[column, j]
        end

      catch err
        error("Wartość zbyt bliska zeru wystąpiła na przekątnej macierzy A ($k, $k)")
      end
    end
  end
end


"""
Funkcja generująca z częściowym wyborem rozkład LU dla zadanej macierzy A. Funkcja operuje na macierzy A, 
modyfikuje ją aż do utworzenia z niej LU. Zwraca wektor P permutacji wierszy macierzy A.

Dane:
A - macierz blokowa postaci zgodnej z listą zadań, rozmiaru nxn, silnie diagonalna
"""
function generateLUPartialPivoting!(A::BlockMatrix)
  n = A.size
  p = [1:n;] # tablica do przechowywania permutacji wykonanych przy wyborze pivota

  # etap I - doprowadzenie A do macierzy górnotrójkątnej
  for column in 1: n-1
    # maxElem = 0
    maxIndex = column
    # for k in column : lastRow(A, column) # znalezienie pivota
    #   if abs(A[p[k], column]) > abs(maxElem)
    #     maxElem = A[p[k], column]
    #     maxIndex = k
    #   end
    # end
    maxIndex = reduce((x, y) -> abs(A[p[x], column]) >= abs(A[p[y], column]) ? x : y, column : lastRow(A, column))
    p[column], p[maxIndex] = p[maxIndex], p[column] # swap uwzględniony w tablicy permutacji
    for i in column+1 : lastRow(A, column)
      try
        l = A[p[i], column] / A[p[column], column] # współczynnik, z pomocą którego zerujemy
        A[p[i], column] = l  # w wyzerowanym polu wstawiamy właśnie ten współczynnik

        for j in column+1 : lastColumn(A, column + A.blockSize) #odejmujemy od pozostałych elementów w wierszu
          A[p[i], j] -= l * A[p[column], j]
        end

      catch err
        error("Wartość zbyt bliska zeru wystąpiła na przekątnej macierzy A ($k, $k)")

      end
    end
  end
  return p
end


"""
Funkcja rozwiązująca układ równań dla zadanego wektora prawych stron i wyliczonego uprzednio
rozkładu LU macierzy A. Modyfikuje ona dostarczony wektor prawych stron. Zwraca rozwiązanie układu równań.

Dane:
LU - macierz rozkładu LU macierzy A; zapisana w jednej macierzy w taki sposób, że pod przekątną
     znajdują się elementy niezerowe macierzy dolnotrójkątnej L, a na przekątnej i nad przekątną
     znajdują się elementy niezerowe macierzy górnotrójkątnej U (na przekątnej macierz L ma same jedynki,
     nie musimy ich przechowywać)
b - wektor prawych stron długości n, jest modyfikowany!
"""
function solveGivenLU!(LU::BlockMatrix, b::Vector{Float64})
  n = LU.size

  # Lz = b , nadrabiamy z wektorem b modyfikacje wynikające z Gaussa
  for k in 1 : (n-1)
    for i in (k+1) : lastRow(LU, k)
      b[i] -= LU[i, k] * b[k]
    end
  end

  # Ux = z, układ równań z macierzą górno trójkątną
  solution = zeros(Float64, n)
  for i in n : -1 : 1
    solution[i] = b[i]
    for j in i+1 : lastColumn(LU, i)
      solution[i] -= LU[i, j] * solution[j]
    end
    solution[i] /= LU[i, i]
  end
  return solution
end


"""
Funkcja rozwiązująca układ równań dla zadanego wektora prawych stron i wyliczonego uprzednio
rozkładu LU z częściowym wyborem macierzy A. Modyfikuje ona dostarczony wektor prawych stron. 
Zwraca rozwiązanie układu równań.

Dane:
LU - macierz rozkładu LU macierzy A; zapisana w jednej macierzy w taki sposób, że pod przekątną
     znajdują się elementy niezerowe macierzy dolnotrójkątnej L, a na przekątnej i nad przekątną
     znajdują się elementy niezerowe macierzy górnotrójkątnej U (na przekątnej macierz L ma same jedynki,
     nie musimy ich przechowywać)
P - wektor permutacji wierszy macierzy A długości n
b - wektor prawych stron długości n, jest modyfikowany!
"""
function solveGivenPartialPivotedLU!(LU::BlockMatrix, P::Vector{Int}, b::Vector{Float64})
  n = LU.size

  # Lz = Pb , nadrabiamy z wektorem b modyfikacje wynikające z Gaussa i częściowego wyboru
  for k in 2 : n
    for i in firstColumn(LU, P[k]) : (k-1)
      b[P[k]] -= LU[P[k], i] * b[P[i]]
    end
  end

  # Ux = z, układ równań z macierzą górno trójkątną
  solution = zeros(n)
  solution[n] = b[P[n]] / LU[P[n], n]
  for i in n-1: -1: 1
    solution[i] = b[P[i]]
    for j in i+1 : lastColumn(LU, i + LU.blockSize)
      solution[i] -= LU[P[i], j] * solution[j]
    end
    solution[i] /= LU[P[i], i]
  end
  return solution
end


"""
Funkcja rozwiązująca układ równań postaci Ax=b metodą rozkładu LU (samemu go generując).

Dane
A - macierz blokowa postaci zgodnej z listą zadań, rozmiaru nxn, silnie diagonalna

b - wektor prawych stron długości n

Zwraca wektor rozwiązania długości n
"""
function solveUsingLU!(A::BlockMatrix, b::Vector{Float64})
  generateLU!(A)
  return solveGivenLU!(A, b)
end


"""
Funkcja rozwiązująca układ równań postaci Ax=b metodą rozkładu LU z częściowym wyborem
(samemu generując ten rozkład).

Dane
A - macierz blokowa postaci zgodnej z listą zadań, rozmiaru nxn, silnie diagonalna

b - wektor prawych stron długości n

Zwraca wektor rozwiązania długości n
"""
function solveUsingPartialPivotedLU!(A::BlockMatrix, b::Vector{Float64})
  P = generateLUPartialPivoting!(A)
  return solveGivenPartialPivotedLU!(A, P, b)
end


end