extends enemy

var damage = 3

var attack_cooldown = 2
var warrior_ant_projectile = preload("res://Nodes/Entity nodes/Enemies/enemy_attacks/larva_projectile.tscn")
@onready var shot_point = $rotator/shot_point
@onready var rotator = $rotator
@onready var hitbox = $Hitbox

var projectiles_per_ranged_attack : int = 5
var direction_change : float 
var direction_difference : float = 10
var moving_speed = 100
var can_melee = false
var ranged_zone_cooldown : float = 5
var follow_cooldown : float = 1

@export var melee_zone : Area2D
func _ready():
	get_player_info_at_spawn()
	direction_change = -deg_to_rad(direction_difference) * 2

func _physics_process(delta):
	
	if attack_cooldown >= 0:
		attack_cooldown -= delta
	if follow_cooldown >= 0:
		follow_cooldown -= delta
	if ranged_zone_cooldown >= 0:
		ranged_zone_cooldown -= delta
	set_warrior_behavior()
	move_and_slide()
	if can_attack == true and attack_cooldown <= 0:
		ranged_attack()
	if can_melee == true and attack_cooldown <= 0:
		melee_attack()
	else:
		hitbox.collider.disabled = true
	

func ranged_attack():
	for i in projectiles_per_ranged_attack:
		var warrior_ant_projectile_instance = warrior_ant_projectile.instantiate()
		get_parent().add_child(warrior_ant_projectile_instance)
		warrior_ant_projectile_instance.global_position = shot_point.global_position
		warrior_ant_projectile_instance.rotation = rotator.rotation + direction_change
		direction_change += deg_to_rad(direction_difference)
		i += 1
	direction_change = -deg_to_rad(direction_difference)
	attack_cooldown = 2
	ranged_zone_cooldown = 5
	follow_cooldown = 1
	
	
func melee_attack():
	hitbox.collider.disabled = false
	await get_tree().create_timer(0.1).timeout
	health_mananger.health = 0
	
	
func set_warrior_behavior():
	if following_zone.get_overlapping_bodies().size() > 0 and following_zone.get_overlapping_bodies()[0] is player and follow_cooldown <= 0:
		can_follow = true
		
	else:
		can_follow = false
	
	if attacking_zone.get_overlapping_bodies().size() > 0 and attacking_zone.get_overlapping_bodies()[0] is player and can_melee == false and ranged_zone_cooldown <= 0:
		can_attack = true
		
	else:
		can_attack = false
	
	if melee_zone.get_overlapping_bodies().size() > 0 and melee_zone.get_overlapping_bodies()[0] is player:
		can_melee = true
		can_attack = false
		can_follow = false
	else:
		can_melee = false
	
	
	
