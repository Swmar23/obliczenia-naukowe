# Marek Świergoń 261750 Obliczenia Naukowe Lista 5
# Program testowy

include("iofuncs.jl")
using .myBlockMatrix
using .blocksys
using .IOFuncs

A = nothing
b = nothing
solution = nothing
target_solution = nothing

LU = nothing
P = nothing
while !eof(stdin)
  command = split(readline(stdin))
  if isempty(command)
    continue
  end
  if command[1] == "exit"
    println()
    break
  elseif command[1] == "readMatrix"
    if length(command) == 2
      try
        @time begin
        global A = readBlockMatrix(String(command[2]), true)
        global b = generateRightVector(A)
        global target_solution = ones(Float64, A.size)
        println("Wczytano macierz.")
        end
      catch err
        println("Nieudane wczytywanie pliku")
      end
    else
      println("Wywołanie: readmatrix filename")
    end
  elseif command[1] == "readVector"
    if length(command) == 2
      try
        @time begin
        global b = readVector(String(command[2]))
        println("Wczytano wektor prawych stron.")
        end
      catch err
        println("Nieudane wczytywanie pliku")
      end
    else
      println("Wywołanie: readvector filename")
    end
  elseif command[1] == "readBoth"
    if length(command) == 3
      try
        @time begin
        global A = readBlockMatrix(String(command[2]), true)
        global b = readVector(String(command[3]))
        global LU = nothing
        global P = nothing
        global solution = nothing
        global target_solution = nothing
        println("Wczytano macierz i wektor prawych stron.")
        end
      catch err
        println("Nieudane wczytywanie pliku")
      end
    else
      println("Wywołanie: readboth filename_matrix, filename_vector")
    end
  elseif command[1] == "solveGauss"
    if A === nothing
      println("Nie wczytano macierzy A!")
    else
      @time begin
      global solution = gaussElimination(A, b)
      global A = nothing
      global b = nothing
      println("Wyliczono rozwiązanie metodą eliminacji Gaussa.")
      end
    end
  elseif command[1] == "solveGaussPivot"
    if A === nothing
      println("Nie wczytano macierzy A!")
    else
      @time begin
      global solution = gaussEliminationPartialPivoting(A, b)
      global A = nothing
      global b = nothing
      println("Wyliczono rozwiązanie metodą eliminacji Gaussa z częściowym wyborem.")
      end
    end
  elseif command[1] == "generateLU"
    if A === nothing
      println("Nie wczytano macierzy A!")
    else
      @time begin
        generateLU!(A)
        global P = nothing
        global LU = A
        global A = nothing
        println("Wygenerowano rozkład LU dla macierzy A.")
      end
    end
  elseif command[1] == "generateLUPivot"
    if A === nothing
      println("Nie wczytano macierzy A!")
    else
      @time begin
        global P = generateLUPartialPivoting!(A)
        global LU = A
        global A = nothing
        println("Wygenerowano rozkład LU dla macierzy A z częściowym wyborem.")
      end
    end
  elseif command[1] == "solveWithLU"
    if LU === nothing || P !== nothing
      println("Najpierw wygeneruj rozkład LU (metodą generateLU)!")
    else
      @time begin
        global solution = solveGivenLU!(LU, b)
        global b = nothing
        println("Wyliczono rozwiązanie z wykorzystaniem rozkładu LU.")
      end
    end
  elseif command[1] == "solveWithLUPivot"
    if LU === nothing || P === nothing
      println("Najpierw wygeneruj rozkład LU z użyciem częściowego wyboru (metodą generateLUPivot)!")
    else
      @time begin
        global solution = solveGivenPartialPivotedLU!(LU, P, b)
        global b = nothing
        println("Wyliczono rozwiązanie z wykorzystaniem rozkładu LU (częściowy wybór).")
      end
    end
  elseif command[1] == "write"
    if solution === nothing 
      println("Nie wyliczono jeszcze rozwiązania!")
    elseif length(command) != 2
      println("Wywołanie: write filename")
    else
      @time begin
      writeSolution(String(command[2]), solution, target_solution)
      println(string("Zapisano wektor rozwiązania do pliku ", command[2]))
      end
    end
  elseif command[1] == "help"
    println("Lista komend:")
    println("readMatrix filename - wczytywanie macierzy z pliku tekstowego")
    println("readVector filename - wczytywanie wektora prawych stron z pliku tekstowego")
    println("readBoth filename_matrix filename_vector - wczytywanie macierzy i wektora z plików tekstowych")
    println("solveGauss - rozwiązanie ukłądu równań Ax=b metodą eliminacji Gaussa bez wyboru")
    println("solveGaussPivot - rozwiązanie układu równań Ax=b metodą eliminacji Gaussa z częściowym wyborem")
    println("generateLU - generowanie rozkładu LU macierzy")
    println("generateLUPivot - generowanie rozkłądu LU macierzy z częściowym wyborem")
    println("solveWithLU - rozwiązanie układu równań Ax=b z użyciem wygenerowanego wcześniej rozkładu LU komendą generateLU")
    println("solveWithLUPivot - rozwiązanie układu równań Ax=b z użyciem wygenerowanego wcześniej rozkładu LU komendą generateLUPivot")
    println("write filename - zapisanie rozwiązania do pliku tekstowego")
    println("help - lista komend")
    println("about - o programie")
    println("exit - wyjście z programu")
  elseif command[1] == "about"
    println("Autor: Marek Świergoń (261750)")
    println("Program testowy rozwiązujący układy równań Ax=b z macierzą o strukturze zgodnej z listą 5 na laboratoria z Obliczeń Naukowych")
    println("PWr, WIiT INA, Obliczenia Naukowe, semestr zimowy 2022/2023")
  else
    println("Nieznane polecenie (aby wyświetlić listę komend wpisz help")
  end
end