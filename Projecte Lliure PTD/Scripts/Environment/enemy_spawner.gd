extends Area2D

class_name enemy_spawner

var enemy_spawn
var x_enemy_spawn_boundaries : Vector2
var y_enemy_spawn_boundaries : Vector2

var tile_location : Vector2
var current_data : TileData
var navigation_layer_value
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#revisa si es troba damunt una peça navegable i si no es miu
	if navigation_layer_value != null:
		spawn_enemy()
		queue_free()
		
	else:
		
		global_position = Vector2i(randi_range(x_enemy_spawn_boundaries.x, x_enemy_spawn_boundaries.y), randi_range(y_enemy_spawn_boundaries.x, y_enemy_spawn_boundaries.y))

func spawn_enemy():
	#fa apareixer un enemic
	var enemy_spawn_instance = enemy_spawn.instantiate()
	get_parent().add_child(enemy_spawn_instance)
	enemy_spawn_instance.global_position = global_position
	enemy_spawn_instance.get_player_info_at_spawn()


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#obté les dades de navegació de la peça en que es troba
	if body is TileMap:
		tile_location = body.get_coords_for_body_rid(body_rid)
		current_data = body.get_cell_tile_data(0, body.get_coords_for_body_rid(body_rid))
		navigation_layer_value = current_data.get_navigation_polygon(0)
		
