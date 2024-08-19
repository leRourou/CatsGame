extends Node
static var rng = RandomNumberGenerator.new()

func check(proba: float) -> bool:
	return rng.randf() < proba

# Dict must have a weight key
func check_pondered_dict(dict: Dictionary):
	var probas = []
	var total_weights = 0
	var values = dict.values() as Array[float]
	for value in values:
		total_weights += value.weight
	for value in values:
		probas.append(value.weight as float / total_weights)
	return dict.keys()[check_multiple(probas)]

# Check multiples probability, sum must be equals to 1
func check_multiple(probas: Array) -> int:
	var index = 0
	var current_proba = 0
	var random_nb = rng.randf()
	for proba in probas:
		current_proba += proba
		if (random_nb > current_proba):
			index += 1
		else: 
			return index
	return -1
