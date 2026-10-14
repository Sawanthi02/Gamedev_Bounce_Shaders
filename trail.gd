extends Line2D
@onready var ball: Ball = $"../.."
@onready var ball_collision: CollisionShape2D = $".."

@export var lifetime : float = 1.5
@export var resolution : float = 3.0

var last_point = Vector2.ZERO
var Point_times := []
var clock := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear_points()
	set_as_top_level(true)
	set_color()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	clock += delta
	set_color()
	remove_old_points()
	
	var desired_point := to_local(ball_collision.global_position)
	var distance := last_point.distance_to(desired_point)
	
	if distance > resolution:
		add_point(desired_point)
		Point_times.append(clock)
		last_point = desired_point

func remove_old_points():
	for creation_time in Point_times:
		var delta = clock - creation_time
		if delta > lifetime:
			remove_first_point()

func remove_first_point():
	if get_point_count() > 1:
		remove_point(0)
		Point_times.pop_front()
		

func set_color():
	var ball_gradient := Gradient.new()
	if !ball.is_ball_one:
		ball_gradient.colors = [ball.colour_ball_one, ball.colour_ball_two]
	else:
		ball_gradient.colors = [ball.colour_ball_two, ball.colour_ball_one]
	
	self.gradient = ball_gradient
