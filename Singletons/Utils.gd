extends Node2D

func uniform(min_value, max_value):
    var range_size = max_value - min_value
    return (randf() * range_size) + min_value


func discrete(i, f):
    var r = f - i
    return floor(randf() * r + i)

func normal(mu, sigma, minimum, maximum):
    var p1 = (randf() * 2) - 1
    var p2 = (randf() * 2) - 1
    var p = p1 * p1 + p2 * p2
    while p >= 1:
        p1 = (randf() * 2) - 1
        p2 = (randf() * 2) - 1
        p = p1 * p1 + p2 * p2
    var n = mu + sigma * p1 * sqrt(-2 * log( p ) / p)
    return max(min(maximum, n), minimum)

func diracs(dirac_array):
    var sum = 0.0
    for dirac in dirac_array:
        sum += dirac
    assert(sum == 1, "ERROR: the sum of the dirac values must be equal to 1!")
    var i = 0
    var acc = dirac_array[0]
    var u = randf()
    while acc != 1:
        if u < acc:
            return i
        i += 1
        acc += dirac_array[i]
    return i

