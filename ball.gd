extends CharacterBody2D
class_name Ball

signal bounced

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var explotionparticle: GPUParticles2D = $Explotionparticle


@export var is_ball_one := false
@export var colour_ball_one := Color('#D8D8F6')
@export var colour_ball_two := Color('#B18FCF')
@export var speed := 75.0


func _ready() -> void:
	# Set the position
	global_position.y = (get_viewport_rect().size.y/2)
	if is_ball_one:
		global_position.x = (get_viewport_rect().size.x/4) + (get_viewport_rect().size.y/2)
	else:
		global_position.x = (get_viewport_rect().size.x/4)

	# Set velocity
	velocity.x = -speed
	velocity.y = randi_range(-15, 15) # randomize that starting velocity a bit.



func _physics_process(delta: float) -> void:
	polygon_2d.color = colour_ball_one if is_ball_one else colour_ball_two
	cpu_particles_2d.color = colour_ball_one if is_ball_one else colour_ball_two
	
	# Set the direction for the particles effect
	cpu_particles_2d.direction = -velocity.normalized()

	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	# If there is a collision, bounce the ball and toggle the collided tile
	if collision:
		# Bounce the velocity to the ball collides
		velocity = velocity.bounce(collision.get_normal())
		animation_player.play("Bounce")
		
		explotionparticle.global_position = collision.get_position()
		explotionparticle.restart()
		
		# If the collision is with a tile, toggle it
		if collision.get_collider() is Tile:
			collision.get_collider().toggle(self)
			cpu_particles_2d.emitting = true
			bounced.emit()


func _get_collision_layer() -> int:
	return collision_layer
