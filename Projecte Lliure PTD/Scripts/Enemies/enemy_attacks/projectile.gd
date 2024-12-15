extends RayCast2D
class_name projectile

@export var speed : float = 6
var dir : Vector2
@export var lifetime : float = 2
@onready var hitbox = $Hitbox

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_colliding()
	handle_lifetime(delta)
	handle_movement()



func _die():
	visible = false
	await get_tree().create_timer(0.1).timeout
	queue_free()

func handle_lifetime(delta : float):
	if lifetime <= 0:
		_die()
	else:
		lifetime -= delta
	
func handle_movement():
	dir = Vector2(cos(rotation), sin(rotation))
	position += dir * speed
	
func handle_colliding():
	if is_colliding() and get_collider() is player or get_collider() is TileMap:
		_die()
	if hitbox.found_hurt_box != null:
		_die()
