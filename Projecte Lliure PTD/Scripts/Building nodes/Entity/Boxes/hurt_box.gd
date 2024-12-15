extends Area2D
class_name hurt_box
@export var health_m : health_manager


func send_damage(damage : float, attack_location : Vector2):
		health_m.take_damage(damage, attack_location)












