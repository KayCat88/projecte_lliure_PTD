extends RayCast2D
class_name projectile

@export var speed : float = 6
var dir : Vector2
@export var lifetime : float = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lifetime <= 0:
		die()
	else:
		lifetime -= delta
	dir = Vector2(cos(rotation), sin(rotation))
	position += dir * speed
	if is_colliding() and get_collider() is player or get_collider() is TileMap:
		die()



func die():
	visible = false
	await get_tree().create_timer(0.02).timeout
	queue_free()
