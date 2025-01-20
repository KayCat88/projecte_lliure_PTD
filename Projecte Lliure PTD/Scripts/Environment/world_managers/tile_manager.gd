extends Node
class_name tile_manager


@export var tilemap : TileMap
@export var player_instance : player
var selected_pattern : Array
var pattern_selector : int
var pattern_list : Array[Array]

var pattern_index : int
var player_spawn_pos : Vector2
var y_enemy_spawn_boundaries : Vector2
var x_enemy_spawn_boundaries : Vector2
var room_number : int
var zone_number : int
# first element is the pattern index, the second the player spawn position, the third the y boundaries and the fourth the x boundaries
var pattern_0 : Array = [0, Vector2(590,570), Vector2(144, 580), Vector2(110, 1050)]


var pattern_1 : Array = [1, Vector2(590,570), Vector2(144, 580), Vector2(110, 1050)]


var pattern_2 : Array = [2, Vector2(580,320), Vector2(150, 490), Vector2(155, 1000)]

var pattern_3 : Array = [3, Vector2(580,320), Vector2(150, 490), Vector2(155, 1000)]

var pattern_4 : Array = [4, Vector2(580,500), Vector2(150, 490), Vector2(155, 1000)]


# Called when the node enters the scene tree for the first time.
func _ready():
	pattern_list = [pattern_0, pattern_1, pattern_2, pattern_3, pattern_4]
	select_new_pattern()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func draw_tiles():
	#crea l'habitació
	
	tilemap.set_pattern(0, Vector2i.ZERO, tilemap.tile_set.get_pattern(pattern_index))
	
func select_new_pattern():
	#selecciona un patró aleatori de la llista i aplica les característiques proporcionades de l'habitació a les variables
	pattern_selector = randi_range(0, pattern_list.size()-1)
	selected_pattern = pattern_list[pattern_selector]
	pattern_index = selected_pattern[0]
	player_spawn_pos = selected_pattern[1]
	y_enemy_spawn_boundaries = selected_pattern[2]
	x_enemy_spawn_boundaries = selected_pattern[3]

func move_player():
	player_instance.global_position = player_spawn_pos
