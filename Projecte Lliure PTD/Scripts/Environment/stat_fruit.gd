extends Area2D

@export_range(0, 3) var stat_to_upgrade : int = 0
var stat_list : Array
var stat_upgrade_value_list : Array



var health_upgrade_value = 1.5
var speed_upgrade_value = 1.5
var speed_loss_upgrade_value = 1.5
var damage_upgrade_value = 1.5



# Called when the node enters the scene tree for the first time.
func _ready():
	stat_upgrade_value_list = [health_upgrade_value, speed_upgrade_value, speed_loss_upgrade_value, damage_upgrade_value]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.

	




func _on_body_entered(body):
	if body is player:
		if stat_to_upgrade == 0:
			body.health_manager_var.health *= health_upgrade_value
		elif stat_to_upgrade == 1:
			body.SPEED *= speed_upgrade_value
		elif stat_to_upgrade == 2:
			body.ball_speed_loss_multiplier *= speed_loss_upgrade_value
		elif stat_to_upgrade == 3:
			body.ball_damage_multiplier *= damage_upgrade_value
