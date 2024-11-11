extends CharacterBody2D

#nodes
var player : CharacterBody2D
@onready var offset: Marker2D = $Offset
@onready var attack_hit_box: Area2D = $AttackHitBox
@onready var searched_size_label: Label = $Searched_size_label
var score_manager : Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
var player_particles = load("res://Assets/Particles/player_hit_particles_2d.tscn")

#variables
var in_attack_range : bool = false
var attack_cooldown = 4
var rotation_smoothing : Vector2
var searched_size : int
#the search types are: 1-under x number, 2-over x number, 3-search for an exact number, 4-between x and y
var possible_search_types_integer : int
var in_search_range : bool = false
var possible_search_types_string_array : Array = ["under", "over", "exactly", "between"]
var health = 3
var can_change_animation = false
var size_value = 1
var size = 1
#constants
const SPEED = 180

const ACCELERATION = 50
const ATTACK_DISTANCE = 15
const ATTACK_COOLDOWN_SETTER = 2

#scenes
var corpse : PackedScene = preload("res://Nodes/Entity nodes/Environment/corpse.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node("Player")
	score_manager = get_parent().get_node("Score_and_difficulty_manager")
	attack_hit_box.monitoring = false
	possible_search_types_integer = randf_range(1, 3) 
	searched_size = randf_range(1, 20)
	
func _process(delta: float) -> void:
	handle_death()
	searched_size_label.text = str(searched_size)
	if size_value <= searched_size-4:
		size_up()
	scale = Vector2(size, size)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handle_searching()
	if in_search_range == true:
		handle_enemy_movement()
		handle_enemy_attacks()
	else:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION)
		velocity.y = move_toward(velocity.y, 0, ACCELERATION)
	move_and_slide()
	if attack_cooldown > -2:
		attack_cooldown -= delta
	
	
func handle_enemy_movement():
	var enemy_movement_rotational_offset : Vector2 = offset.global_position-position
	
	rotation_smoothing = lerp(rotation_smoothing, player.position, 0.15 )
	look_at(rotation_smoothing)
	
	
	if position.x - player.position.x < ATTACK_DISTANCE and position.x - player.position.x > -ATTACK_DISTANCE :
		velocity.x = move_toward(velocity.x, 0, ACCELERATION)
		await get_tree().create_timer(0.2).timeout
		in_attack_range = true
	else:
		velocity.x = move_toward(velocity.x, SPEED*enemy_movement_rotational_offset.x*(size**-1), ACCELERATION)
		in_attack_range = false
	
	if position.y - player.position.y < ATTACK_DISTANCE and position.y - player.position.y > -ATTACK_DISTANCE :
		velocity.y = move_toward(velocity.y, 0, ACCELERATION)
		
		in_attack_range = true
	else:
		velocity.y = move_toward(velocity.y, SPEED*enemy_movement_rotational_offset.y*(size**-1), ACCELERATION)
		in_attack_range = false

func handle_enemy_attacks():
	if in_attack_range == true and attack_cooldown <= 0:
		animated_sprite_2d.play("Enemy_Attack")
		attack_hit_box.monitoring = true
		attack_cooldown = ATTACK_COOLDOWN_SETTER
		
	elif can_change_animation == true: 
		animated_sprite_2d.play("Enemy_Idle")
		attack_hit_box.monitoring = false
		can_change_animation = false
	else:
		attack_hit_box.monitoring = false
		

func _on_attack_hit_box_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("PLAYER"):
		audio_stream_player_2d.play()
		area.get_parent().health -= 1
		var player_particles_instance = player_particles.instantiate()
		get_parent().add_child(player_particles_instance)
		player_particles_instance.global_position = player.global_position
		player_particles_instance.rotation = player.rotation
		player_particles_instance.scale = player.scale
		player_particles_instance.emitting = true

func handle_searching():
		if player.size_value > searched_size:
			in_search_range = true
		else: 
			in_search_range = false
	

func handle_death():
	if health <= 0:
		score_manager.score += 100
		var corpse_instance = corpse.instantiate()
		get_parent().add_child(corpse_instance)
		corpse_instance.global_position = global_position
		corpse_instance.rotation = rotation
		corpse_instance.scale = scale
		corpse_instance.add_to_group("CORPSE")
		queue_free()
	
	


func _on_animated_sprite_2d_animation_finished() -> void:
	can_change_animation = true
	
func size_up():
	size += (0.5/(2**size))
	size_value += 1
