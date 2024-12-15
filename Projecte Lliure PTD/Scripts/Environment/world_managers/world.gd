extends Node2D

@onready var enemy_spawn_manager_var = $enemy_spawn_manager
@onready var tile_manager_var = $tile_manager
@onready var reward_manager_var = $reward_manager

# Called when the node enters the scene tree for the first time.
func _ready():
	set_enemy_boundaries()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_enemy_boundaries():
	enemy_spawn_manager_var.y_enemy_spawn_boundaries = tile_manager_var.y_enemy_spawn_boundaries
	enemy_spawn_manager_var.x_enemy_spawn_boundaries = tile_manager_var.x_enemy_spawn_boundaries
