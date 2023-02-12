# obliczenia-naukowe
Zbiorcze repozytorium rozwiązań zadań z Obliczeń Naukowych (metody numeryczne). Kurs prowadzony przez prof. dra hab. Pawła Zielińskiego na kierunku Informatyka Algorytmiczna, Wydział Informatyki i Telekomunikacji Politechniki Wrocławskiej.

Programy napisane w języku Julia ([instrukcja](https://julialang.org/downloads/) instalacji języka).

### Lista 1
Arytmetyki zmiennopozycyjne w standardzie IEEE 754. Wyznaczenie epsilona maszynowego, liczby eta oraz MAX. Rozmieszczenie liczb maszynowych w arytmetyce podwójnej precyzji (double, Float64). Eksperymentalne sprawdzenie błędów numerycznych różnych algorytmów wyliczania iloczynu skalarnego. Wpływ odejmowania liczb bliskich sobie na błędy numeryczne. Wyznaczanie wartości pochodnej funkcji z definicji, dla zmniejszających się odstępów $h$ - analiza błędów.

### Lista 2
Złe uwarunkowanie wyliczania iloczynu skalarnego dla wektorów prawie prostopadłych. Analiza błędu numerycznego wyliczania granicy zadanej funkcji. Błedy względne rozwiązywania układu równań $Ax = b$ dla źle uwarunkowanej macierzy Hilberta i macierzy losowych o różnych wskaźnikach uwarunkowania. Złośliwy wielomian Wilkinsona i problemy w wyliczaniu jego pierwiastków dla nieznacznie zaburzonych danych. Numeryczna niestabilność wyznaczania wartości modelu logistycznego, zjawisko sprzężenia zwrotnego. Pojęcie deterministycznego chaosu.

### Lista 3
Iteracyjne metody poszukiwania miejsca zerowego zadanej funkcji: metoda bisekcji, Newtona (stycznych), siecznych. Testowanie rodzaju zbieżności (zbieżność lokalna/globalna) oraz wykładnika zbieżności dla zadanych w treści zadań funkcji.

### Lista 4
Zagadnienie numerycznej interpolacji wielomianami stopnia co najwyżej n. Wyznaczanie ilorazów różnicowych jako współczynników kombinacji liniowej bazy wielomianów w postaci Newtona. Zoptymalizowane obliczanie wartości wielomianu interpolacyjnego w zadanym punkcie. Przekształcanie postaci Newtona na postać naturalną. Rysowanie wykresów obrazujących skuteczność interpolacji wielomianowej dla zadanej funkcji i maksymalnego stopnia wielomianu przy strategii doboru węzłów równoodległych.

### Lista 5
Implementacja numerycznych metod rozwiązywania układu równań $Ax = b$ zoptymalizowana dla specyficznej macierzy blokowej A (opisanej w pliku autorstwa profesora prowadzącego kurs).
Algorytmy wyznaczania rozkładu LU (bez lub z częściowym wyborem elementu głównego) oraz rozwiązywania układu równań metodą eliminacji Gaussa (analogicznie bez lub z częściowym wyborem elementu głównego).
