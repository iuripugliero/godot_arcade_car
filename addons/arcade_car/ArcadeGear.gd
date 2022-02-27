extends Resource

export var id: int
export var ratio: float
export var minimum_speed: float
export var top_speed: float
export var neutral: bool
export var reverse: bool

func get_id():
	return self.id

func get_minimum_speed():
	return self.minimum_speed

func get_maximum_speed():
	return self.top_speed

func get_ratio():
	return self.ratio

func is_reverse():
	return reverse

func get_modifier():
	if self.reverse == true:
		return (-1)
	else:
		return 1

func is_neutral():
	return self.neutral
