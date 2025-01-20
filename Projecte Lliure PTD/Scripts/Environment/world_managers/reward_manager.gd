extends Node
class_name reward_manager

var health_fruit : PackedScene = preload("res://Nodes/Entity nodes/Environment/health_stat_fruit.tscn")
var stamina_fruit : PackedScene = preload("res://Nodes/Entity nodes/Environment/stamina_stat_fruit.tscn")
var damage_fruit : PackedScene = preload("res://Nodes/Entity nodes/Environment/damage_stat_fruit.tscn")
var boost_fruit : PackedScene = preload("res://Nodes/Entity nodes/Environment/bounce_boost_stat_fruit.tscn")

var reward_list : Array[PackedScene]
var has_reward_been_dropped : bool = false
var fruits_in_scene = 0
var has_reward_been_picked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	reward_list = [health_fruit, stamina_fruit, damage_fruit, boost_fruit]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#revisa si després de deixar la recompensa encara es troba en el món i si no decideix que ja esta agafada
	if has_reward_been_dropped == true:
		fruits_in_scene = 0
		for child in get_parent().get_children():
			if child is stat_fruit:
				fruits_in_scene += 1
				
		if fruits_in_scene == 0:
			has_reward_been_picked = true
		
	
	
func drop_reward(spawn_pos : Vector2):
	#crea la recompensa allà on apareix el jugador al principi de l'habitació
	var reward_instance = reward_list[randi_range(0, 3)].instantiate()
	get_parent().add_child(reward_instance)
	reward_instance.global_position = spawn_pos
	has_reward_been_dropped = true
