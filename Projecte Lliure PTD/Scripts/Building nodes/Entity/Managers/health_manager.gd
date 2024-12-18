extends Node2D
class_name health_manager

@export var knockback_strenght = 500
@export var max_health : int = 10
@export var hit_effect : String
var hit_effect_scene
var health
var dir : Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	hit_effect_scene = load(hit_effect)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		_die()
func take_damage(damage : float, attack_location : Vector2):
	
	dir = to_local(attack_location).normalized()
	var hit_effect_instance = hit_effect_scene.instantiate()
	get_parent().add_child(hit_effect_instance)
	hit_effect_instance.global_position = global_position
	hit_effect_instance.rotation = rotation
	hit_effect_instance.emitting = true
	
	
	get_parent().velocity = Vector2(dir.x, -dir.y) * knockback_strenght
	health -= damage
	
func _die():
	get_parent().queue_free()
