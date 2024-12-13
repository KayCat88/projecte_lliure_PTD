extends Node
class_name health_manager

@export var health : int = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		die()
func take_damage(damage : float):
	health -= damage
func die():
	get_parent().queue_free()
