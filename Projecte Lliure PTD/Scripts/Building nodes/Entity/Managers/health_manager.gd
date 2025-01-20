extends Node2D
class_name health_manager

@export var knockback_strenght = 50
@export var max_health : int = 10
@export var hit_effect : String
@export var hurt_sound : String = "res://Assets/SFX/Enemies/enemy_hurt.wav"
var hit_effect_scene
var health
var dir : Vector2
@onready var audio_stream_player_2d = $AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	hit_effect_scene = load(hit_effect)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		_die()
func take_damage(damage : float, attack_location : Vector2):
	#aplica retrocés segons la posició proporcionada, fa l'efecte de mal i resta la vida corresponent
	dir = to_local(attack_location).normalized()
	var hit_effect_instance = hit_effect_scene.instantiate()
	get_parent().add_child(hit_effect_instance)
	hit_effect_instance.global_position = global_position
	hit_effect_instance.rotation = rotation
	hit_effect_instance.emitting = true
	
	audio_stream_player_2d.stream = load(hurt_sound)
	audio_stream_player_2d.play()
	get_parent().velocity = Vector2(dir.x, -dir.y) * knockback_strenght
	health -= damage
	
func _die():
	get_parent().queue_free()
