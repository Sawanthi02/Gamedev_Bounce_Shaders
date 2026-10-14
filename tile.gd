extends StaticBody2D
class_name Tile

@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

@export var ball: Ball

func _ready() -> void:
	set_color()


func toggle(collided_ball: Ball) -> void:
	ball = collided_ball

	# Set collision layer to layer that the collided ball is on.
	collision_layer = ball._get_collision_layer()

	# Switch colour
	explode(polygon_2d.color)
	set_color()


func set_color() -> void:
	# Set the colour to the opposite ball's colour
	if ball.is_ball_one:
		polygon_2d.color = ball.colour_ball_two
	else:
		polygon_2d.color = ball.colour_ball_one

func explode(color : Color):
	cpu_particles_2d.color = color;
	cpu_particles_2d.restart()
	cpu_particles_2d.emitting = true
