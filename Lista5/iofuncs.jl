# Marek Świergoń 261750 Obliczenia Naukowe Lista 5
# Plik z metodami I/O

include("blocksys.jl")

module IOFuncs
export readBlockMatrix, readVector, writeSolution
using SparseArrays
using LinearAlgebra
using Main.myBlockMatrix

"""
Funkcja do wczytywania macierzy blokowej z pliku o konkretnym formacie,
tj. w pierwszej linijce rozmiar macierzy i rozmiar bloku oddzielony spacją,
w kolejnych linijkach po jednym rekordzie postaci współrzędne oddzielone spacją
i wartość.

Dane:
filename - nazwa pliku, z którego zostanie wczytana macierz
optimise - czy zastosować optymalizację przy tworzeniu macierzy (dodanie sztucznych zer
           przyspieszających wyliczanie rozwiązań )
"""
function readBlockMatrix(filename::String, optimise::Bool)
  open(filename) do file
    args = split(readline(file))
    size = parse(Int, args[1])
    blockSize = parse(Int, args[2])
    values = Vector{Float64}()
    xcords = Vector{Int}()
    ycords = Vector{Int}()
    while !eof(file)
      line = split(readline(file))
      i = parse(Int, line[1])
      j = parse(Int, line[2])
      v = parse(Float64, line[3])
      push!(xcords, i)
      push!(ycords, j)
      push!(values, v)
    end
    
    if (optimise)
      A = newBlockMatrixOptimized(size, blockSize, xcords, ycords, values)
    else
      A = newBlockMatrix(size, blockSize, xcords, ycords, values)
    end
    return A
  end
end


"""
Funkcja do wczytywania wektora wartości z pliku o specjalnym formacie,
tj. w pierwszej linijce rozmiar wektora i w kolejnych linijkach po jednej wartości
wektora.
"""
function readVector(filename::String)
  open(filename) do file
    n = parse(Int, readline(file))
    vector = zeros(n)
    for i in 1:n
      vector[i] = parse(Float64, readline(file))
    end
    return vector
  end
end

"""
Funkcja zapisuje rozwiązanie równania liniowego razem z błędem względnym popełnionym
przy rozwiązywaniu.
"""
function writeSolution(filename::String, solution::Vector{Float64}, target_solution::Union{Nothing, Vector{Float64}})
  open(filename, "w") do file
    if target_solution !== nothing
      error = norm(solution - target_solution) / norm(target_solution)
      write(file, "$error\n")
    end
    for x in solution
      write(file, "$x\n")
    end
  end
end


end