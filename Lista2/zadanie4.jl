#Marek Świergoń 261750 Obliczenia Naukowe Lista 2 zadanie 4
using Polynomials, Printf

#Metoda wylicza pierwiastki wielomianu o zadanych tablicą coefficients wspołczynnikach a0, a1, ..., an
function calculateRoots(coefficients)
  polynomialCanonicalForm = Polynomial(coefficients)
  # println("Polynomial (in canonical form): ", polynomialCanonicalForm)
  rootsComputed = roots(polynomialCanonicalForm)
  println("k | z_k | abs(z_k - k)")
  for i in 1:lastindex(rootsComputed)
      if (typeof(rootsComputed[i]) == Float64)
          @printf("%d & %.15f & %.15f\n", i, rootsComputed[i], abs(rootsComputed[i] - i))
      else 
          println(i, " & ", rootsComputed[i], " & ", abs(rootsComputed[i] - i))
      end
  end
  return rootsComputed
end

#Metoda wylicza wartości wielomianu Wilkinsona zadanego postacią naturalną
function printAbsValCanonical(coefficients, values)
  polynomialCanonicalForm = Polynomial(coefficients)
  for i in eachindex(values)
    @printf("|P(z_%d)| = %.15e\n", i, abs(polynomialCanonicalForm(values[i])))
  end
end

# Metoda wylicza wartości wielomianu Wilkinsona zadanego postacią iloczynową
function printAbsValFactored(values)
  # tutaj zadajemy wielomian wprost w postaci iloczynowej 
  polynomialFactoredForm = fromroots(1:20)
  # println("Polynomial (in factored form): ", polynomialFactoredForm)
  for i in eachindex(values)
    @printf("|p(z_%d)| = %.15e\n", i, abs(polynomialFactoredForm(values[i])))
  end
end

#Skopiowane współczynniki wielomianu Wilkinsona
p = [1, -210.0, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]
# Poly constructor requires first a0 then a1, ..., an
coefficients = p[end:-1:1]

rootsComputed = calculateRoots(coefficients)
printAbsValCanonical(coefficients, rootsComputed)
printAbsValFactored(rootsComputed)

#dodatkowe sprawdzenie czy prawdziwe pierwiastki zadziałają
polynomialCanonicalForm = Polynomial(coefficients)
polynomialFactoredForm = fromroots(1:20)
println("Dodatkowe sprawdzenie, czy prawidłowe pierwiastki zadziałają:")
for k in 1:20
  @printf("%d & %.15e & %.5e\n", k, abs(polynomialCanonicalForm(k)), abs(polynomialFactoredForm(k)))
end

# Zaburzenie wielomianu Wilkinsona
coefficientsNoised = copy(coefficients)
coefficientsNoised[20] = -210.0 - (1.0/(2.0^23))
# println(coefficients[20])
# println(coefficientsNoised[20])

println("\n\nPierwiastki zaburzonego wielomianu:")
rootsComputedNoised = calculateRoots(coefficientsNoised)