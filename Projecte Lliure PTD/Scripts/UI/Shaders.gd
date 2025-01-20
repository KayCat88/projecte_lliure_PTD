extends ColorRect

@export var player_node : player
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_node.is_in_slowed_mode == true:
		visible = true
	else: 
		visible = false
