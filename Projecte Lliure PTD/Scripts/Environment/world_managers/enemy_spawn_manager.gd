extends Node

#variables to get from higher noes
	#this variable is used to determine the credits received. it goes from 1 to 15
var difficulty_level : int
	#this variable is used to determine the number of waves and also the credits received. it goes from 1 to 3
var difficulty_tier : int


var difficulty_multiplier : int


#variables from this node
var waves : int
var credits : int = 10
var low_tier_enemy_cost : int = 1
var high_tier_enemy_cost : int = 2
var next_enemy_tier_value : int
var next_enemy_type_value : int



var low_tier_enemies : Array
var high_tier_enemies : Array
var enemies_to_spawn_in_this_wave : Array

#enemy scenes to spawn
var worker_ant_spawn : PackedScene = preload("res://Nodes/Entity nodes/Enemies/worker_ant.tscn")
var shooter_ant_spawn : PackedScene = preload("res://Nodes/Entity nodes/Enemies/shooter_ant.tscn")
var larva_spawn : PackedScene = preload("res://Nodes/Entity nodes/Enemies/larva.tscn")
var warrior_ant_spawn : PackedScene = preload("res://Nodes/Entity nodes/Enemies/warrior_ant.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	
	low_tier_enemies = [worker_ant_spawn, shooter_ant_spawn]
	high_tier_enemies = [larva_spawn, warrior_ant_spawn]
	determine_enemy_spawns()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("u"):
		spawn_enemy_wave()
	
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
	for i in enemies_to_spawn_in_this_wave:
		var enemy_spawn_instance = enemies_to_spawn_in_this_wave[i].instantiate()
		get_parent().add_child(enemy_spawn_instance)
		enemy_spawn_instance.global_position = Vector2(randi_range(4800, 5300), randi_range(0, 300))
		
	

