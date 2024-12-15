extends NavigationAgent2D
var player_target : player
@export var enemy_parent : enemy
@export var speed : float = 10
@export var rotator : Marker2D
var deceleration : float

var rotation_smoothing 
# Called when the node enters the scene tree for the first time.
func _ready():
	deceleration = speed/50


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	
	rotator.look_at(player_target.global_position)
	
	var dir = enemy_parent.make_navigation_calculations(get_next_path_position()) 
	if enemy_parent.can_follow == true:
		
		enemy_parent.velocity = dir * speed 
	else:
		enemy_parent.velocity.x = move_toward(enemy_parent.velocity.x, Vector2.ZERO.x, deceleration)
		enemy_parent.velocity.y = move_toward(enemy_parent.velocity.y, Vector2.ZERO.y, deceleration)
	
	
	

	
func make_path():
	target_position = player_target.global_position
	

func _on_timer_timeout():
	make_path()


