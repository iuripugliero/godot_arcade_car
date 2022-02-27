tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("ArcadeCar", "VehicleBody", preload("ArcadeCar.gd"), preload("arcade_car_icon.png"))
	add_custom_type("ArcadeWheel", "VehicleWheel", preload("ArcadeWheel.gd"), preload("arcade_wheel_icon.png"))
	add_custom_type("ArcadeGearbox", "Resource", preload("ArcadeGearbox.gd"), preload("arcade_gearbox_icon.png"))
	add_custom_type("ArcadeGear", "Resource", preload("ArcadeGear.gd"), preload("arcade_gear_icon.png"))
	add_custom_type("ArcadeController", "Spatial", preload("ArcadeController.gd"), preload("arcade_controller_icon.png"))

func _exit_tree():
	remove_custom_type("ArcadeCar")
	remove_custom_type("ArcadeWheel")
	remove_custom_type("ArcadeGearbox")
	remove_custom_type("ArcadeGear")
	remove_custom_type("ArcadeController")

