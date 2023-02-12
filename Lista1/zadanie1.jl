#Marek Świergoń 261750 Obliczenia Naukowe Lista 1, zadanie 1

function machepsFL16()::Float16
  fl16::Float16 = Float16(1.0)
  fl16new::Float16 = fl16/2
  while Float16(1.0) + fl16new > Float16(1.0)
    fl16 = fl16new
    fl16new = fl16/2
  end
  return fl16
end

function machepsFL32()::Float32
  fl32::Float32 = Float32(1.0)
  fl32new::Float32 = fl32/2
  while Float32(1.0) + fl32new > Float32(1.0)
    fl32 = fl32new
    fl32new = fl32/2
  end
  return fl32
end

function machepsFL64()::Float64
  fl64::Float64 = Float64(1.0)
  fl64new::Float64 = fl64/2
  while Float64(1.0) + fl64new > Float64(1.0)
    fl64 = fl64new
    fl64new = fl64/2
  end
  return fl64
end

function etaFL16()::Float16
  fl16::Float16 = Float16(1.0)
  fl16new::Float16 = fl16/2
  while fl16new > Float16(0.0)
    fl16 = fl16new
    fl16new = fl16/2
  end
  return fl16
end

function etaFL32()::Float32
  fl32::Float32 = Float32(1.0)
  fl32new::Float32 = fl32/2
  while fl32new > Float32(0.0)
    fl32 = fl32new
    fl32new = fl32/2
  end
  return fl32
end

function etaFL64()::Float64
  fl64::Float64 = Float64(1.0)
  fl64new::Float64 = fl64/2
  while fl64new > Float64(0.0)
    fl64 = fl64new
    fl64new = fl64/2
  end
  return fl64
end

function maxFL16()::Float16
  fl16::Float16 = 1.0
  fl16new::Float16 = fl16*2
  while !isinf(fl16new)
    fl16 = fl16new
    fl16new = fl16 * 2
  end
  step::Float16 = fl16 / 2
  while (step > 0.0 && fl16 + step > fl16)
    fl16new = fl16 + step
    if !isinf(fl16new)
      fl16 = fl16new
    else
      step /= 2
    end
  end
  return fl16
end

function maxFL32()::Float32
  fl32::Float32 = 1.0
  fl32new::Float32 = fl32*2
  while !isinf(fl32new)
    fl32 = fl32new
    fl32new = fl32 * 2
  end
  step::Float32 = fl32 / 2
  while (step > 0.0 && fl32 + step > fl32)
    fl32new = fl32 + step
    if !isinf(fl32new)
      fl32 = fl32new
    else
      step /= 2
    end
  end
  return fl32
end

function maxFL64()::Float64
  fl64::Float64 = 1.0
  fl64new::Float64 = fl64*2
  while !isinf(fl64new)
    fl64 = fl64new
    fl64new = fl64 * 2
  end
  step::Float64 = fl64 / 2
  while (step > 0.0 && fl64 + step > fl64)
    fl64new = fl64 + step
    if !isinf(fl64new)
      fl64 = fl64new
    else
      step /= 2
    end
  end
  return fl64
end

println(machepsFL16())
println(eps(Float16))
println(machepsFL32())
println(eps(Float32))
println(machepsFL64())
println(eps(Float64))
println(etaFL16())
println(nextfloat(Float16(0.0)))
println(etaFL32())
println(nextfloat(Float32(0.0)))
println(etaFL64())
println(nextfloat(Float64(0.0)))
println(floatmin(Float32))
println(floatmin(Float64))
println(maxFL16())
println(floatmax(Float16))
println(maxFL32())
println(floatmax(Float32))
println(maxFL64())
println(floatmax(Float64))
