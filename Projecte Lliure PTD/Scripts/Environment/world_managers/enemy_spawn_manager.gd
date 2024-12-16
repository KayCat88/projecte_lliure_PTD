extends Node
class_name enemy_spawn_manager
#variables to get from higher noes
	#this variable is used to determine the credits received. it goes from 1 to 15
var difficulty_level : int = 1
	#this variable is used to determine the number of waves and also the credits received. it goes from 1 to 3
var difficulty_tier : int = 1


var difficulty_multiplier : int = 1
var can_spawn : bool

var y_enemy_spawn_boundaries : Vector2
var x_enemy_spawn_boundaries : Vector2
#variables from this node
var has_level_been_cleared : bool = false
var waves : int
var has_wave_been_cleared : int = 1
var waves_cleared : int = 0
var credits : int 

var low_tier_enemy_cost : int = 1
var high_tier_enemy_cost : int = 2
var next_enemy_tier_value : int
var next_enemy_type_value : int



var low_tier_enemies : Array
var high_tier_enemies : Array
var enemies_to_spawn_in_this_wave : Array[PackedScene]

#enemy scenes to spawn
var worker_ant_spawn : PackedScene = preload("res://Nodes/Entity nodes/Enemies/worker_ant.tscn")
var shooter_ant_spawn : PackedScene = preload("res://Nodes/Entity nodes/Enemies/shooter_ant.tscn")
var larva_spawn : PackedScene = preload("res://Nodes/Entity nodes/Enemies/larva.tscn")
var warrior_ant_spawn : PackedScene = preload("res://Nodes/Entity nodes/Enemies/warrior_ant.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	calculate_wave_and_credit_numbers()
	low_tier_enemies = [worker_ant_spawn, shooter_ant_spawn]
	high_tier_enemies = [larva_spawn, warrior_ant_spawn]
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	manage_enemies_killed()
	if Input.is_action_just_pressed("u"):
		determine_enemy_spawns()
		spawn_enemy_wave()
	if Input.is_action_just_pressed("j"):
		debug_clear_enemies()
	
	
func calculate_wave_and_credit_numbers():
	waves = difficulty_tier * difficulty_multiplier
	
	credits = difficulty_level * difficulty_tier * difficulty_multiplier + 2
	
func determine_enemy_spawns():
	while credits > 0:
		next_enemy_tier_value = randi_range(0, 1)
		next_enemy_type_value = randi_range(0, 1)
		if next_enemy_tier_value == 0:
			enemies_to_spawn_in_this_wave.append(low_tier_enemies[next_enemy_type_value])
			credits-=low_tier_enemy_cost
		elif next_enemy_tier_value == 1 and credits >= 2:
			enemies_to_spawn_in_this_wave.append(high_tier_enemies[next_enemy_type_value])
			credits-=high_tier_enemy_cost
		elif next_enemy_tier_value == 1 and credits < 2:
			enemies_to_spawn_in_this_wave.append(low_tier_enemies[next_enemy_type_value])
			credits-=low_tier_enemy_cost

func spawn_enemy_wave():
	for enemy_spawn in enemies_to_spawn_in_this_wave:
		var enemy_spawn_instance = enemy_spawn.instantiate()
		get_parent().add_child(enemy_spawn_instance)
		enemy_spawn_instance.global_position = Vector2(randi_range(x_enemy_spawn_boundaries.x, x_enemy_spawn_boundaries.y), randi_range(y_enemy_spawn_boundaries.x, y_enemy_spawn_boundaries.y))
		enemy_spawn_instance.get_player_info_at_spawn()
	
	enemies_to_spawn_in_this_wave.clear()
	
func debug_clear_enemies():
	for enemy_to_clear in get_parent().get_children():
		if enemy_to_clear is enemy:
			enemy_to_clear.queue_free()
	
func manage_enemies_killed():
	
	if can_spawn == true:
		for child in get_parent().get_children():
			if child is enemy:
				has_wave_been_cleared += 1
		
		
			
		if has_wave_been_cleared <= 0 and waves_cleared < waves:
			calculate_wave_and_credit_numbers()
			determine_enemy_spawns()
			spawn_enemy_wave()
			waves_cleared += 1
		elif has_wave_been_cleared <= 0 and waves_cleared == waves:
			waves_cleared += 1
		if waves_cleared > waves:
			has_level_been_cleared = true 
			reset_numbers()
		else:
			has_level_been_cleared = false
		has_wave_been_cleared = 0
		
func reset_numbers():
	waves_cleared = 0
	waves = 0
	credits = 0
	enemies_to_spawn_in_this_wave.clear()
	
	
