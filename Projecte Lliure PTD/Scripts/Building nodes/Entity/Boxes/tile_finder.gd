extends Area2D

var current_data : TileData
var current_data_value_dps : float
@export var hurtbox : hurt_box
var on_damage_tile = false
var damage_tile_timer = 1
var tile_location : Vector2
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if on_damage_tile == true and damage_tile_timer <= 0:
		send_damage_from_tile()
		damage_tile_timer = 1
	elif damage_tile_timer > 0:
		damage_tile_timer -= delta
		
func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#obté les dades de la peça en que es troba i determina si es troba damunt una peça danyina
	if body is TileMap:
		tile_location = body.get_coords_for_body_rid(body_rid)
		current_data = body.get_cell_tile_data(0, body.get_coords_for_body_rid(body_rid))
		current_data_value_dps = current_data.get_custom_data_by_layer_id(0)
		if current_data_value_dps > 0:
			on_damage_tile = true
		else:
			on_damage_tile = false
	
func send_damage_from_tile():
	hurtbox.send_damage(current_data_value_dps, tile_location)



