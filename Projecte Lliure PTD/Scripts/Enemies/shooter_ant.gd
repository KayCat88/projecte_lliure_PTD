extends enemy

var damage = 3

var attack_cooldown = 2
var shooter_ant_projectile = preload("res://Nodes/Entity nodes/Enemies/enemy_attacks/shooter_ant_projectile.tscn")
@onready var shot_point = $rotator/shot_point
@onready var rotator = $rotator

var moving_speed = 100
func _ready():
	get_player_info_at_spawn()


func _physics_process(delta):
	
	if attack_cooldown >= 0:
		attack_cooldown -= delta
	set_behavior()
	move_and_slide()
	if can_attack == true and attack_cooldown <= 0:
		attack()
	

func attack():
		var shooter_ant_projectile_instance = shooter_ant_projectile.instantiate()
		get_parent().add_child(shooter_ant_projectile_instance)
		shooter_ant_projectile_instance.global_position = shot_point.global_position
		shooter_ant_projectile_instance.rotation = rotator.rotation
		attack_cooldown = 2


	
	
