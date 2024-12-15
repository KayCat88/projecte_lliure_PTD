extends Node

@export var tilemap : TileMap
@export var player_instance : player
var selected_pattern : Array
var pattern_selector : int
var pattern_list : Array[Array]

var pattern_index : int
var player_spawn_pos : Vector2
var y_enemy_spawn_boundaries : Vector2
var x_enemy_spawn_boundaries : Vector2

# first element is the pattern index, the second the player spawn position, the third the y boundaries and the fourth the x boundaries
var pattern_0 : Array = [0, Vector2(373,173), Vector2(), Vector2()]


var pattern_1 : Array = [0, Vector2(373,173), Vector2(), Vector2()]


var pattern_2 : Array = [0, Vector2(373,173), Vector2(), Vector2()]


# Called when the node enters the scene tree for the first time.
func _ready():
	pattern_list = [pattern_0, pattern_1, pattern_2]
	select_new_pattern()
	draw_tiles()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("j"):
		move_player()

func draw_tiles():
	
	tilemap.set_pattern(0, Vector2i.ZERO, tilemap.tile_set.get_pattern(pattern_index))
	
func select_new_pattern():
	pattern_selector = randi_range(0, pattern_list.size()-1)
	

	selected_pattern = pattern_list[pattern_selector]
	pattern_index = selected_pattern[0]
	player_spawn_pos = selected_pattern[1]
	y_enemy_spawn_boundaries = selected_pattern[2]
	x_enemy_spawn_boundaries = selected_pattern[3]

func move_player():
	player_instance.global_position = player_spawn_pos