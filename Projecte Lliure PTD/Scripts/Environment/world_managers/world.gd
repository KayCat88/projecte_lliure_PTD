extends Node2D

@onready var enemy_spawn_manager_var = $enemy_spawn_manager
@onready var tile_manager_var = $tile_manager
@onready var reward_manager_var = $reward_manager
@onready var scene_preparation_timer = $scene_preparation_timer
@onready var tile_to_enemy_spawner = $tile_to_enemy_spawner
@onready var level_ender = $level_ender

@export var player_node :player
var is_scene_ready : bool = false
var are_enemies_ready : bool = false
var level_finished : bool
var game_master_node : game_master
var final_timer_activated = false
var room_number
var zone_number

var reward_dropped = false
# Called when the node enters the scene tree for the first time.
func _ready():
	game_master_node = get_parent()
	set_enemy_boundaries()
	scene_preparation_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#canvia els valors del enemyspawner seons l'habitacio i aixi es determinen els credits
	enemy_spawn_manager_var.difficulty_level =  room_number
	enemy_spawn_manager_var.difficulty_tier = zone_number
	
	new_scene()
	#revisa que s'hagin matat els enemics i dona la recompensa
	#despres revisa que s'hagi agafat la recompensa i activa el canvi de sala
	if enemy_spawn_manager_var.has_level_been_cleared == true and reward_dropped == false:
		reward_manager_var.drop_reward(tile_manager_var.player_spawn_pos)
		reward_dropped = true
	if reward_manager_var.has_reward_been_picked == true and final_timer_activated == false:
		level_ender.start()
		final_timer_activated = true
func set_enemy_boundaries():
	#defineix alla on poden sortir els enemics segons la sala
	enemy_spawn_manager_var.y_enemy_spawn_boundaries = tile_manager_var.y_enemy_spawn_boundaries
	enemy_spawn_manager_var.x_enemy_spawn_boundaries = tile_manager_var.x_enemy_spawn_boundaries

func _on_scene_preparation_timer_timeout():
	is_scene_ready = true

func _on_tile_to_enemy_spawner_timeout():
	are_enemies_ready = true

func new_scene():
	#si s'ha acabat el temporitzador inicial, es dibuixa la sala i s'activa el temporitzador que fara sortir els enemics
	if is_scene_ready == true:
		tile_manager_var.select_new_pattern()
		tile_manager_var.draw_tiles()
		tile_manager_var.move_player()
		set_enemy_boundaries()
		tile_to_enemy_spawner.start()
		is_scene_ready = false
	if are_enemies_ready == true:
		enemy_spawn_manager_var.can_spawn = true
		


func _on_level_ender_timeout():
	game_master_node.new_level()
