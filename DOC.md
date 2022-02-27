# Documentation

## Introduction
This is the docs and script reference for Godot plugin [ArcadeCar](https://github.com/iuripugliero/godot_arcade_car).

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
