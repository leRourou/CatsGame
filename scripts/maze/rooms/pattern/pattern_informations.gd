class_name PatternInfos extends Node2D

const PATTERNS_INFORMATIONS: Dictionary = {
	Pattern.Type.SINGLE: {
		"weight": 30,
		"remove_if_not_placable": [],
	},
	Pattern.Type.SQUARE_2: {
		"weight": 15,
		"remove_if_not_placable": [Pattern.Type.SQUARE_2, Pattern.Type.SQUARE_3]
	},
	Pattern.Type.SQUARE_3: {
		"weight": 5,
		"remove_if_not_placable": []
	},
	Pattern.Type.TRIANGLE_1: {
		"weight": 5,
		"remove_if_not_placable": [Pattern.Type.SQUARE_2, Pattern.Type.SQUARE_3]
	},
	Pattern.Type.TRIANGLE_2: {
		"weight": 5,
		"remove_if_not_placable": [Pattern.Type.SQUARE_2, Pattern.Type.SQUARE_3]
	},
	Pattern.Type.TRIANGLE_3: {
		"weight": 5,
		"remove_if_not_placable": [Pattern.Type.SQUARE_2, Pattern.Type.SQUARE_3]
	},
	Pattern.Type.TRIANGLE_4: {
		"weight": 5,
		"remove_if_not_placable": [Pattern.Type.SQUARE_2, Pattern.Type.SQUARE_3]
	},
	Pattern.Type.LONG_2: {
		"weight": 10,
		"remove_if_not_placable": [
			Pattern.Type.LONG_3,
			Pattern.Type.TRIANGLE_1,
			Pattern.Type.TRIANGLE_2,
			Pattern.Type.TRIANGLE_3,
			Pattern.Type.TRIANGLE_4,
			Pattern.Type.SQUARE_2,
			Pattern.Type.SQUARE_3,
		]
	},
	Pattern.Type.LONG_3: {
		"weight": 5,
		"remove_if_not_placable": [
			Pattern.Type.SQUARE_3,
		]
	},
	Pattern.Type.LARGE_2: {
		"weight": 10,
		"remove_if_not_placable": [
			Pattern.Type.LARGE_3,
			Pattern.Type.TRIANGLE_1,
			Pattern.Type.TRIANGLE_2,
			Pattern.Type.TRIANGLE_3,
			Pattern.Type.TRIANGLE_4,
			Pattern.Type.SQUARE_2,
			Pattern.Type.SQUARE_3,
		]
	},
	Pattern.Type.LARGE_3: {
		"weight": 5,
		"remove_if_not_placable": [
			Pattern.Type.SQUARE_3,
		]
	}
}


# Returns patterns that will be removed when a pattern can't be placed on a maze
static func get_patterns_to_remove(pattern: Pattern.Type):
	return PATTERNS_INFORMATIONS[pattern].remove_if_not_placable
