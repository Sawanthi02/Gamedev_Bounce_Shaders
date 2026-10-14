extends Node2D

var total_bounce : int = 1
@onready var ball_1: Ball = %Ball1
@onready var ball_2: Ball = %Ball2
@onready var tiles: Node2D = $Tiles
@onready var camera_2d: shake_camera = $Camera2D
@onready var timer: Timer = $Timer

@export var bounce_minimum : int = 5

func _on_ball_2_bounced() -> void:
	bounce_counter()


func _on_ball_1_bounced() -> void:
	bounce_counter()


func bounce_counter():
	shake_camera.shaking()
	
	total_bounce = total_bounce + 1
	if (total_bounce % bounce_minimum == 0):
		var new_color_1 = Color(randf(), randf(), randf())
		var new_color_2 = Color(randf(), randf(), randf())
		
		ball_1.colour_ball_one = new_color_1
		ball_1.colour_ball_two = new_color_2
		
		ball_2.colour_ball_one = new_color_1
		ball_2.colour_ball_two = new_color_2
		
		Engine.time_scale = 0.3
		reload_board_color()
		timer.start()
		

func reload_board_color():
	for tile in tiles.get_children():
		tile.set_color()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
