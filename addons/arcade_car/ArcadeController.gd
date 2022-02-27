extends Spatial


func get_arcade_car():
	var temp = self.get_parent()
	if temp is preload("res://addons/arcade_car/ArcadeCar.gd"):
		return temp
	else:
		return null
