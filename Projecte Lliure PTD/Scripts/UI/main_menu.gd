extends Control

var game_master_node : game_master
# Called when the node enters the scene tree for the first time.
func _ready():
	game_master_node = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	game_master_node.load_run()


func _on_tutorial_button_pressed():
	game_master_node.load_tutorial()


func _on_credits_button_pressed():
	game_master_node.load_credits()
