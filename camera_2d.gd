extends Camera2D
class_name shake_camera

var random = RandomNumberGenerator.new()

static var strength: float = 0.0

# Called when the node enters the scene tree for the first time.
static func shaking():
	strength = 10.0

func randomOffset() -> Vector2:
	return Vector2(random.randf_range(-strength, strength), random.randf_range(-strength, strength))
	
func _process(delta: float) -> void:
	if strength > 0:
		strength = lerpf(strength, 0, 5.0 * delta)
		
		offset = randomOffset()
