tool
extends VehicleWheel

#class_name BulletWheel

var left_wheel: bool
var right_wheel: bool
var rear_wheel: bool

func _get_property_list() -> Array:
	var ret: Array = []
	ret.append({
		"name": "ArcadeWheel",
		"type": TYPE_NIL,
		"usage": PROPERTY_USAGE_CATEGORY
	})
	ret.append({
		"name": "wheel_type",
		"type": TYPE_NIL,
		"usage": PROPERTY_USAGE_GROUP,
	})
	ret.append({
		"name": "left_wheel",
		"type": TYPE_BOOL,
	})
	ret.append({
		"name": "right_wheel",
		"type": TYPE_BOOL,
	})
	ret.append({
		"name": "rear_wheel",
		"type": TYPE_BOOL,
	})
	return ret


func get_wheel_type():
	if self.left_wheel == true:
		return 1
	elif self.right_wheel == true:
		return 2
	elif self.rear_wheel == true:
		return 0
	else:
		return null
