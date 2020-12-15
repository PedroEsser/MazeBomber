extends Node2D

func uniform(min_value, max_value):
    var range_size = max_value - min_value
    return (randf() * range_size) + min_value


func discrete(i, f):
    var r = f - i
    return floor(randf() * r + i)