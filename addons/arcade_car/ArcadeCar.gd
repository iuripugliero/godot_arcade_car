tool
extends VehicleBody

#class_name BulletCar




var engine_power: float
var core_rotation: int
var redline_rotation: int
var maximum_steering: float
var engine_rotation: int
var gearbox : Resource setget set_gearbox, get_gearbox
var current_gear : int
var current_gear_object
var blueline
var velocity
var left_wheel
var right_wheel
var back_wheel
var reverse_modifier: int



func get_rotation():
	return engine_rotation

func get_gearbox():
	return gearbox

func set_gearbox(value):
	if value is preload("res://addons/arcade_car/ArcadeGearbox.gd"):
		gearbox = value
		gearbox.resource_name = "ArcadeGearbox"
	else:
		gearbox = null


func _get_property_list() -> Array:
	var ret: Array = []
	ret.append({
		"name": "ArcadeCar",
		"type": TYPE_NIL,
		"usage": PROPERTY_USAGE_CATEGORY
	})
	ret.append({
		"name": "properties",
		"type": TYPE_NIL,
		"usage": PROPERTY_USAGE_GROUP,
	})
	ret.append({
		"name": "engine_power",
		"type": TYPE_INT,
	})
	ret.append({
		"name": "core_rotation",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0, 10000, 100"
	})
	ret.append({
		"name": "redline_rotation",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0, 10000, 100"
	})
	ret.append({
		"name": "maximum_steering",
		"type": TYPE_REAL,
		"hint": PROPERTY_HINT_EXP_RANGE,
		"hint_string": "0,1.57,.01"
	})
	ret.append({
		"name": "resource",
		"type": TYPE_NIL,
		"usage": PROPERTY_USAGE_GROUP,
	})
	ret.append({
		"name": "gearbox",
		"type": typeof(Resource),
		"hint": PROPERTY_HINT_RESOURCE_TYPE,
		"hint_string": "ArcadeGearbox",               
	})
	return ret

func auto_scale(a1,a2,a3,b1,b2):
	var f1 = float(a1)
	var f2 = float(a2)
	var f3 = float(a3)
	var fa = float(b1)
	var fb = float(b2)
	var fc = ((((f3-f2)/(f1-f2))*(fa-fb))+fb)
	return fc

func power_func():
	var power = engine_power*5
	var ratio = current_gear_object.get_ratio()
	if engine_rotation < core_rotation:
		var temp_low
		if ratio > 1:
			temp_low = 1/ratio
		else:
			temp_low = ratio
		var temp_rot = pow(auto_scale(0, core_rotation, engine_rotation, temp_low, 1), 1/ratio)
		return ceil(temp_rot*power)
	else:
		var temp_high
		if ratio > 1:
			temp_high = 2/ratio
		else:
			temp_high = ratio
		var temp_rot = pow(auto_scale(core_rotation, redline_rotation, engine_rotation, 1, temp_high), 1/(ratio*2))
		return ceil(temp_rot*power)

func gear_picker():
	if not Engine.editor_hint:
		current_gear_object = gearbox.get_gear(current_gear)
		if current_gear_object != null:
			reverse_modifier = current_gear_object.get_modifier()

func engine_rotate(delta):
	if  current_gear_object != null and current_gear_object.is_neutral() == false:
		var rot_temp = auto_scale(current_gear_object.get_minimum_speed(), current_gear_object.get_maximum_speed(), velocity, 0, redline_rotation)
		var x = auto_scale(0, 10000, rot_temp, 0, 1)
		#print(rot_temp," ",x)
		if rot_temp > redline_rotation:
			engine_rotation = redline_rotation
		elif rot_temp > blueline:
			engine_rotation = rot_temp
		else:
			engine_rotation = blueline
	elif current_gear_object != null and current_gear_object.is_neutral() == true:
		if engine_rotation-(blueline*delta*10) > blueline:
			engine_rotation -= (blueline*delta*10)
		else:
			engine_rotation = blueline
	else:
		engine_rotation = 0

func wheel_picker(wheel):
	for child in get_children():
		if child is preload("res://addons/arcade_car/ArcadeWheel.gd"):
			if wheel == child.get_wheel_type():
				return child

func ackermann_angle(inner_angle, left_wheel, right_wheel, back_wheel):
	var w = abs(left_wheel.get_translation().x)+abs(right_wheel.get_translation().x)
	var l = abs(left_wheel.get_translation().z)+abs(back_wheel.get_translation().z)
	var cot = 1/(tan(inner_angle))
	var outer = cot - (w/l)
	return atan(outer)
	return 0

func steer_left(weight, delta):
	if left_wheel != null and right_wheel != null and back_wheel != null:
		var fixed_maximum = ackermann_angle(maximum_steering, left_wheel, right_wheel, back_wheel)
		if left_wheel.steering < 0:
			left_wheel.steering += fixed_maximum*delta*weight		
		elif left_wheel.steering < (maximum_steering):
			left_wheel.steering += (maximum_steering)*delta*weight
		else:
			left_wheel.steering = (maximum_steering)
		if right_wheel.steering < 0:
			right_wheel.steering += (maximum_steering)*delta*weight
		elif right_wheel.steering < fixed_maximum:
			right_wheel.steering += fixed_maximum*delta*weight
		else:
			right_wheel.steering < fixed_maximum
	else:
		pass

func steer_right(weight, delta):
	if left_wheel != null and right_wheel != null and back_wheel != null:
		var fixed_maximum = ackermann_angle(maximum_steering, left_wheel, right_wheel, back_wheel)
		if right_wheel.steering > 0:
			right_wheel.steering -= fixed_maximum*delta*weight
		elif right_wheel.steering > -(maximum_steering):
			right_wheel.steering -= (maximum_steering)*delta*weight
		else:
			right_wheel.steering = -(maximum_steering)
		if left_wheel.steering > 0:
			left_wheel.steering -= (maximum_steering)*delta*weight
		elif left_wheel.steering > -fixed_maximum:
			left_wheel.steering -= fixed_maximum*delta*weight
		else:
			left_wheel.steering < -fixed_maximum
	else:
		pass

func clear_steer(weight, delta):
	if left_wheel != null and right_wheel != null and back_wheel != null:
		var fixed_maximum = ackermann_angle(maximum_steering, left_wheel, right_wheel, back_wheel)
		if left_wheel.steering > 0 and left_wheel.steering-(maximum_steering*delta*weight) > 0:
				left_wheel.steering -= maximum_steering*delta*weight
				right_wheel.steering -= fixed_maximum*delta*weight 
		elif right_wheel.steering < 0 and left_wheel.steering+(maximum_steering*delta*weight) < 0:
				right_wheel.steering += maximum_steering*delta*weight
				left_wheel.steering += fixed_maximum*delta*weight
		else:
				left_wheel.steering = 0
				right_wheel.steering = 0
	else:
		pass

func engine_accelerate(delta):
	if current_gear_object.is_neutral() == true:
		if engine_rotation < redline_rotation:
			engine_rotation += engine_power
		else:
			engine_rotation = redline_rotation
	else:
		var temp_power = power_func()
		var temp_ratio = current_gear_object.get_ratio()
		if velocity < current_gear_object.get_minimum_speed():
			engine_force = abs(auto_scale(blueline, redline_rotation, engine_rotation, (temp_power)*temp_ratio, temp_power/(temp_ratio*.5))*reverse_modifier)/abs(3*engine_rotation-blueline)
		elif velocity > current_gear_object.get_maximum_speed():
			engine_force = 0
		else:
			engine_force = temp_power*reverse_modifier

func brakes(maximum, weight, delta):
	var temp = (weight*maximum*delta)+self.brake
	if temp <= maximum:
		self.brake += temp
	else:
		self.brake = maximum

func shift_up():
	if current_gear < gearbox.get_gear_max():
		current_gear += 1
		gear_picker()

func shift_down():
	if current_gear > gearbox.get_gear_min():
		current_gear -= 1
		gear_picker()

func shift_to(gear):
	current_gear = gear
	gear_picker()

func auto():
	if gearbox.get_gearbox_type() == true and current_gear_object != null and current_gear_object.is_neutral() == false:
		if engine_rotation > (core_rotation+redline_rotation)*(0.6/current_gear_object.get_ratio()) and current_gear_object.get_id() > 0:
			shift_up()
		elif engine_rotation < (blueline+core_rotation)/4 and current_gear_object.get_id() > 1:
			shift_down()

func _ready():
	if not Engine.editor_hint:
		blueline = redline_rotation/10
		left_wheel = wheel_picker(1)
		right_wheel = wheel_picker(2)
		back_wheel = wheel_picker(0)
		gear_picker()


func _physics_process(delta):
	if not Engine.editor_hint:
		velocity = self.linear_velocity.length()*3.6
		engine_rotate(delta)
		auto()
