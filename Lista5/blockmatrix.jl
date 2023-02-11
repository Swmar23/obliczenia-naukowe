# Marek Świergoń 261750 Obliczenia Naukowe Lista 5
# Plik opisujący strukturę przechowującej macierz

module myBlockMatrix
export BlockMatrix, emptyBlockMatrix, newBlockMatrix, newBlockMatrixOptimized,
       firstColumn, lastColumn,
       firstRow, lastRow
using SparseArrays

"""
Propozycja struktury do przechowywania macierzy blokowej specyficznej 
dla zadania, z wykorzystaniem SparseArrays.
"""
mutable struct BlockMatrix
  matrix::SparseMatrixCSC{Float64, Int}
  size::Int
  blockSize::Int
  numberOfBlocks::Int
  elementAccessCount::Int
  elementChangesCount::Int
end

# Geter zliczający liczbę operacji odczytu
function Base.getindex(A::BlockMatrix, i::Int, j::Int)
  A.elementAccessCount += 1
  return A.matrix[i, j]
end

# Seter pracujący na danym obiekcie (nie tworzy kopii),
# zliczający liczbę operacji zapisu
function Base.setindex!(A::BlockMatrix, x::Float64, i::Int, j::Int)
  A.matrix[i, j] = x
  A.elementChangesCount +=1
end

function Base.:*(A::BlockMatrix, V::Vector{Float64})
  if length(V) != A.size
    error("Niezgodne ze sobą rozmiary macierzy i wektora")
  end
  result = zeros(Float64, A.size)
  for i in 1:A.size
    for j in firstColumn(A, i):lastColumn(A, i)
      result[i] += V[j] * A[i, j]
    end
  end
  return result
end


"""
Konstruktor pustej kwadratowej macierzy blokowej.

Dane:
size - rozmiar macierzy
blockSize - rozmiar bloku (podany w zadaniu jako l, musi dzielić size)

Zwraca pustą macierz blokową.
"""
function emptyBlockMatrix(size::Int, blockSize::Int)
  if(size % blockSize != 0)
    error("blockSize nie dzieli size!")
  end
  numberOfBlocks = Int(size / blockSize)
  A = spzeros(size, size)
  return BlockMatrix(A, size, blockSize, numberOfBlocks, 0, 0)
end

"""
Konstruktor kwadratowej macierzy blokowej wypełnionej podanymi wartościami.

Dane:
size - rozmiar macierzy
blockSize - rozmiar bloku (podany w zadaniu jako l, musi dzielić size)
values - wektor wartości postaci (numerkolumny, numerwiersza, wartość)

Zwraca macierz blokową z przepisanymi wartościami z wektora values
"""
function newBlockMatrix(size::Int, blockSize::Int, xcords::Vector{Int}, ycords::Vector{Int}, values::Vector{Float64})
  if(size % blockSize != 0)
    error("blockSize nie dzieli size!")
  end
  numberOfBlocks = Int(size / blockSize)
  A = sparse(xcords, ycords, values)
  # display(A)
  return BlockMatrix(A, size, blockSize, numberOfBlocks, 0, 0)
end

"""
Konstruktor zoptymalizowanej kwadratowej macierzy blokowej wypełnionej podanymi wartościami.
Dzięki wstawianiu zer w odpowiednie miejsca (patrz komentarze) przyspiesza znacząco
działanie programu, szczególnie dla macierzy o małych rozmiarach bloków

Dane:
size - rozmiar macierzy
blockSize - rozmiar bloku (podany w zadaniu jako l, musi dzielić size)
values - wektor wartości postaci (numerkolumny, numerwiersza, wartość)

Zwraca macierz blokową z przepisanymi wartościami z wektora values
"""
function newBlockMatrixOptimized(size::Int, blockSize::Int, xcords::Vector{Int}, ycords::Vector{Int}, values::Vector{Float64})
  if(size % blockSize != 0)
    error("blockSize nie dzieli size!")
  end
  numberOfBlocks = Int(size / blockSize)
  # Ważny fragment kodu z punktu wydajności programu!!!
  # Dodajemy zera w miejscach, do których się będziemy odwoływać
  # Odwoływanie się do wpisanego wprost zera niż do elementu pustego
  # jest znacznie szybsze (różnice o rzędy wielkości)

  #wypełniamy zerami bloki b_i
  for blockNo in 0:numberOfBlocks-2
    for i in (2+blockSize*blockNo):(blockSize-1+blockSize*blockNo)
      for j in (blockSize*(blockNo+1)+2):(i+blockSize)
        push!(xcords, j)
        push!(ycords, i)
        push!(values, 0.0)
      end
    end
    # wypełniamy zerami elementy pod przekątną bloków c_i
    for i in (blockSize+1+blockSize*blockNo):(blockSize+blockSize-1+blockSize*blockNo)
      for j in (i-blockSize+1):(blockSize*(blockNo+1))
        push!(xcords, j)
        push!(ycords, i)
        push!(values, 0.0)
      end
    end
  end

  # dodajemy blockSize-1 zer na prawo od elementów "przekątnej" w bloku c_i
  # bardzo usprawnia przy liczeniu rozkładu z cześciowym wyborem
  for i in 1:(size-blockSize-1) 
    for j in (i+blockSize):min(size, i+2*blockSize-1)
      push!(xcords, i)
      push!(ycords, j)
      push!(values, 0.0)
    end
  end
  A = sparse(xcords, ycords, values)
  # display(A)
  return BlockMatrix(A, size, blockSize, numberOfBlocks, 0, 0)
end


# Funkcja zwraca indeks pierwszej od lewej kolumny mającej niezerową
# wartość w danym wierszu macierzy blokowej
function firstColumn(M::BlockMatrix, rowIndex::Int)
  if(rowIndex % M.blockSize == 1)
    return max(1, rowIndex - M.blockSize)
  end
  return max(1, rowIndex - ((rowIndex - 1) % M.blockSize) - 1)
end

# Funkcja zwraca indeks ostatniej od lewej kolumny mającej niezerową
# wartość w danym wierszu macierzy blokowej
function lastColumn(M::BlockMatrix, rowIndex::Int)
  return min(M.size, M.blockSize + rowIndex)
end

# Funkcja zwraca indeks pierwszego od góry wiersza mającego niezerową
# wartość w danej kolumnie macierzy blokowej
function firstRow(M::BlockMatrix, columnIndex::Int)
  return max(1, columnIndex - M.blockSize)
end

# Funkcja zwraca indeks ostatniego od góry wiersza mającego niezerową
# wartość w danej kolumnie macierzy blokowej
function lastRow(M::BlockMatrix, columnIndex::Int)
  if(columnIndex % M.blockSize == 0)
    return min(M.size, columnIndex + M.blockSize)
  end
  return min(M.size, columnIndex + M.blockSize - ((columnIndex - 1) % M.blockSize))
end

end