extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var tile_mouse_pos = local_to_map(mouse_pos)
	if Input.is_action_just_pressed("j"):
		set_cell(0, tile_mouse_pos, 1, Vector2i(1, 1))
