extends CharacterBody2D
class_name enemy 
var speed = 100

var player_target : player
var calculated_next_path_position 

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _ready():
	get_player_info_at_spawn()
func _physics_process(delta):
	
	move_and_slide()
	
	
func get_player_info_at_spawn():
	for child in get_parent().get_children():
		if child is player:
			player_target = child
			break
	if player_target != null:
		nav_agent.player_target = player_target



func make_navigation_calculations(raw_next_path_position : Vector2) -> Vector2:
	calculated_next_path_position = to_local(raw_next_path_position).normalized()
	return calculated_next_path_position


	
