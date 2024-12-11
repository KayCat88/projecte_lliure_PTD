extends NavigationAgent2D
var player_target : player
@export var enemy_parent : enemy
@export var speed : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta):
	var dir = enemy_parent.make_navigation_calculations(get_next_path_position()) 
	
	enemy_parent.velocity = dir * speed
	
	
	
func make_path():
	target_position = player_target.global_position
	

func _on_timer_timeout():
	make_path()
