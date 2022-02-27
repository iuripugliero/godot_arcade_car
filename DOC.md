# Documentation

## Introduction
This is the docs and script reference for Godot plugin [ArcadeCar](https://github.com/iuripugliero/godot_arcade_car).

**_Important note_**
Due to Godot editor export limitations the class uses *tool* mode. For this, it's methods should be executed on an *ArcadeController* extension. Click [here]() for more details.

## Properties

![ArcadeCarIcon](https://github.com/iuripugliero/godot_arcade_car/blob/main/addons/arcade_car/arcade_car_icon.png)   **ArcadeCar**

*int* **engine_power** - The engine peak power, in horsepower. Note that this number is a theorical approximation.

*int* **core_rotation** - The rotation in wich engine will deliver peak power defined on **engine_power**. Good values are around 3000.

*int* **redline_rotation** - The maximum rotation engine can handle. This value and it's one-tenth counterpart gets sync with the speeds defined in gears *(see below)*. Try something close to 6500 for a popular and 8000~9000 for a race or supercar

*float* **maximum_steering** - The maximum angle for steering, in radians.

*resource* **gearbox** - Gearbox resorce object.

##

![ArcadeWheelIcon](https://github.com/iuripugliero/godot_arcade_car/blob/main/addons/arcade_car/arcade_wheel_icon.png)   **ArcadeWheel**

*bool* **left_wheel** - If true, Ackermann's geometry will consider it left.

*bool* **right_wheel** - If true, Ackermann's geometry will consider it right.

*bool* **rear_wheel** - If true, Ackermann's geometry will consider it rear. Only one rear wheel need this flag, since it uses the wheel axis.

##

![ArcadeGearboxIcon](https://github.com/iuripugliero/godot_arcade_car/blob/main/addons/arcade_car/arcade_gearbox_icon.png)   **ArcadeGearbox**

*bool* **automatic** - If true, car changes gears automatic. *This feature is not ready yet and have known issues.*

*array* **gears** - An array containing all the gears resources.

##

![ArcadeGearIcon](https://github.com/iuripugliero/godot_arcade_car/blob/main/addons/arcade_car/arcade_gear_icon.png)   **ArcadeGear**

*int* **id** - The gear ID. Use it for a gear hierarchy.

*float* **ratio** - The gear ratio used on plugin internal power functions. In real life it corresponds to how many spins the engine do for one wheel spin. Higher values goes to lower gears and vice-versa. Try something close to 4.0 on 1st gear and 0.89 on 5th.

*float* **minimum_speed** - The gear corresponding speed to one-tenth of **redline_rotation**. Acceleration on a car slower than this will be greatly attenued. Starts with 0 on 1st gear and rise according.

*float* **top_speed** - The gear corresponding speed of **redline_rotation**. This is also the speed limit of car, when set on the last gear (it will limit even if it has power to go beyond).

*bool* **neutral** - If true, accelerating in it will only rise rotation, but gets no power. *Consider using ID = 0 for neutral gear.*

*bool* **reverse** - If true, accelerating in it will result in backwards movement. *Consider using ID < 0 for reverse gears.*

## Methods

![ArcadeControllerIcon](https://github.com/iuripugliero/godot_arcade_car/blob/main/addons/arcade_car/arcade_controller_icon.png)   **ArcadeController**

*ArcadeCar* **get_arcade_car**( ) - Return it's parent, if it is an ArcadeCar class. Extent your script on this node as a child of ArcadeCar node. This way, no user code will run on editor while exposing custom properties.

##

![ArcadeCarIcon](https://github.com/iuripugliero/godot_arcade_car/blob/main/addons/arcade_car/arcade_car_icon.png)   **ArcadeCar**

*void* **engine_accelerate**( ) - Apply force on the car based on it's gear and speed.

*void* **steer_left**(*weight, delta*) - Steer car to the left, using ackermann's geometry. *weight* = 1 takes one second to fully steer and = 2 takes half second.

*void* **steer_right**(*weight, delta*) - Steer car to the right, using ackermann's geometry. *weight* = 1 takes one second to fully steer and = 2 takes half second.

*void* **clear_steer**(*weight, delta*) - Steer car back to forward. *weight* = 1 takes one second to fully steer and = 2 takes half second.

*void* **brakes**(*maximum, weight, delta*) - Increase braking force until *maximum*.

*void* **shift_up**( ) - Shift the current gear for the next one in gearbox.

*void* **shift_down**( ) - Shift the current gear for the previous one in gearbox.

*void* **shift_to**(*gear*) - Shift the current gear for the one with ID property equals *gear*.

##

![ArcadeWheelIcon](https://github.com/iuripugliero/godot_arcade_car/blob/main/addons/arcade_car/arcade_wheel_icon.png)   **ArcadeWheel**

*int* **get_wheel_type**( ) - Returns 1 for left, 2 for right and 0 for rear.

##

![ArcadeGearboxIcon](https://github.com/iuripugliero/godot_arcade_car/blob/main/addons/arcade_car/arcade_gearbox_icon.png)   **ArcadeGearbox**

*bool* **get_gearbox_type**( ) - Returns true if *automatic*.

*gear* **get_gear**(*integer*) - Return the gear in array with corresponding ID.

*int* **get_gear_max**( ) - Return the highest ID gear. *Note this returns it's ID and get_gear(int) still should be call*.

*int* **get_reverse_gear**( ) - Returns the ID of the first gear found with the *reverse* flag.
