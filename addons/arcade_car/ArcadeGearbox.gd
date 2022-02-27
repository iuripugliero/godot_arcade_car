tool
extends Resource


export var automatic: bool
export(Array, Resource) var gears setget set_gear

func get_gearbox_type():
	return automatic

func set_gear(value):
	gears.resize(value.size())
	gears = value
	for i in gears.size():
		if not gears[i]:
			gears[i] = preload("ArcadeGear.gd").new()
			gears[i].resource_name = "ArcadeGear"

func get_gear(gear):
	for i in gears:
		var real_temp = i.get_id()
		if gear == real_temp:
			return i

func get_gear_max():
	var is_temp
	for i in gears:
		if is_temp == null:
			is_temp = i
		elif i.get_id() > is_temp.get_id():
			is_temp = i
	if is_temp == null:
		return null
	else:
		return is_temp.get_id()

func get_gear_min():
	var is_temp
	for i in gears:
		if is_temp == null and i.is_reverse() == false:
			is_temp = i
		elif i.is_reverse() == false and i.get_id() < is_temp.get_id():
			is_temp = i
	if is_temp == null:
		return null
	else:
		return is_temp.get_id()

func get_first_gear():
	var is_temp
	for i in gears:
		if is_temp == null and (i.is_neutral() == false or i.is_reverse() == false):
			is_temp = i
		elif is_temp != null and i.get_ratio() > is_temp.get_ratio():
			is_temp = i
	if is_temp == null:
		return null
	else:
		return is_temp.get_id()

func get_reverse_gear():
	for i in gears:
		if i.is_reverse() == true:
			return i.get_id()
