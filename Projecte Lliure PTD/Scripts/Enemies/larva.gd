extends enemy

var damage = 3

var attack_cooldown = 2
var larva_projectile = preload("res://Nodes/Entity nodes/Enemies/enemy_attacks/larva_projectile.tscn")
var death_particles = preload("res://Assets/Particles/larva_explosion_particles_2d.tscn")
var explosion_sound = preload("res://Assets/SFX/Enemies/larva_explosion.wav")
var shooting_sound = preload("res://Assets/SFX/Enemies/larva_shoot.wav")
@onready var shot_point = $rotator/shot_point
@onready var rotator = $rotator
@onready var hitbox = $Hitbox
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

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
	#revisa tots els temps d'enfredament i els fa baixar
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
	#per cada projectil que pugui tirar gira cap allà on es tira i els crea. també fa els efectes.
	for i in projectiles_per_ranged_attack:
		var larva_projectile_instance = larva_projectile.instantiate()
		get_parent().add_child(larva_projectile_instance)
		larva_projectile_instance.global_position = shot_point.global_position
		larva_projectile_instance.rotation = rotator.rotation + direction_change
		direction_change += deg_to_rad(direction_difference)
		i += 1
	direction_change = -deg_to_rad(direction_difference)
	attack_cooldown = 2
	ranged_zone_cooldown = 5
	follow_cooldown = 1
	audio_stream_player_2d.stream = shooting_sound
	audio_stream_player_2d.play()
	
	
func melee_attack():
	#fa els efectes, activa la hitbox i es mata
	audio_stream_player_2d.stream = explosion_sound
	audio_stream_player_2d.play()
	hitbox.collider.disabled = false
	var death_particles_instance = death_particles.instantiate()
	get_parent().add_child(death_particles_instance)
	death_particles_instance.global_position = hitbox.global_position
	death_particles_instance.rotation = rotator.rotation
	death_particles_instance.emitting = true
	await get_tree().create_timer(0.1).timeout
	health_mananger.health = 0
	
	
func set_warrior_behavior():
	#revisa en quina zona es troba el jugador i els temps de refredament i el segueix o ataca si pot
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
	
	
	
