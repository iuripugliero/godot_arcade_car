# Arcade Car

## Intro
Hello everyone, this is my very first plugin althoug I should start with something more simple. Still it is an VehicleBody and VehicleWheel extensions (with two new resources too) that aims to provide a very easy and fast way to setup cars and their respectives gearboxes on Godot. It includes features like ackermann's angle, a 'fake' engine rotation scale and some other tools to properly set the car acceleration according to it's gears speed and ratio. However, the car is still powered by force push and should not be used in realistic car simulations (torque on wheels, etc).

This plugin can be viewed working on [YouTube](https://www.youtube.com/watch?v=w73LRuFZ2zg).

## What does it really do?
The plugin internally run a method wich returns the rotation the actual vehicle speed represents in a scale from 1/10 to 1/1 of parameter **redline_rotation**. The speed scale values are user inputed on each gear (meaning that **x** speed are in different rotations for different gears). This way power are delivered to the car in a smooth way. After reaching up it's peak power (delivered on car **core_rotation**), it will start to descend until reaching **redline_rotation**. The speed and amplitude of this acend and descend is relative to gear's **ratio** property (lower gears **wich have higher ratios** descend faster and greater).
Below, take a look at how the power should rise with different gears:
![Image](https://github.com/iuripugliero/godot_arcade_car/blob/main/power_graphs.png)

Please, note that for sake of easing my plots, all powers rise from 0 on the image. On the actual plugin, it rises with different initial powers to gears. This also helps the car wins inertia.

## Docs
[See Here](https://github.com/iuripugliero/godot_arcade_car/blob/main/DOC.md)

## Features

### Drag and drop by design
Just fill the fields with your values and let math do the hard work.

![Image4](https://github.com/iuripugliero/godot_arcade_car/blob/main/drag_drop.png)

### Custom gearboxes and gears resources
Gears and gearboxes are resource storated, and thus fully interchangeable between cars.

![Image5](https://github.com/iuripugliero/godot_arcade_car/blob/main/resources.png)


### Ackermann's angle
For a car to steer properly, both wheels should be autonomous steered. This is because the outer wheel of a curve must cover a greater terrain (and thus spinning more). On a very very very realistic performance car simulation, it may be useful to invert ackermann's (this is done in real life on F1). But since we are not considering hot tires deforming, ackermann's helps us a lot (it reduces tire slipping and this avoid speed loss or immediate stops). The image below represents the angle difference on each wheel:
![Image2](https://github.com/iuripugliero/godot_arcade_car/blob/main/ackermanns.png)

Image is courtesy of [Wikipedia](https://en.wikipedia.org/wiki/Ackermann_steering_geometry)

With ArcadeWheel class, this will be automatically calculated, you just need to tell wich wheel are wich.

![Image3](https://github.com/iuripugliero/godot_arcade_car/blob/main/arcade_wheel.png)

## Known issues
- Warning on the custom resource gearbox export in editor. Still, the gearbox class fits on the export, so it runs fine even with the warning.
- Automatic shift algorithm not ready yet
