extends Node2D
class_name health_manager

@export var knockback_strenght = 1000
@export var health : int = 10
var dir : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		die()
func take_damage(damage : float, attack_location : Vector2):
	
	dir = to_local(attack_location).normalized()
	print(dir)
	
	health -= damage
	get_parent().velocity = Vector2(dir.x, -dir.y) * knockback_strenght
	
func die():
	get_parent().queue_free()
