extends CharacterBody2D

class_name player
#constants
var SPEED
var default_speed = 250.0
@export var ACCELERATION = 122.2
@export var DECELERATION = 122.2

#variables
var rotation_smoothing : Vector2
var boost_cooldown = 0.3


var direction : Vector2
var has_ball : bool = true

var ball_damage_multiplier = 1
var bounce_boost_multiplier = 1

var max_stamina = 100
var stamina = 100
var stamina_depletion_rate = 150
var stamina_recovery_rate = 30
var is_in_slowed_mode : bool
#nodes
@export var camera : Camera2D
@onready var shot_point: Marker2D = $ShotPoint
@onready var attack_box_collision = $bounce_box/CollisionShape2D

@onready var catching_box = $Catching_box
@onready var bounce_box = $bounce_box
@onready var hurt_box_var = $hurt_box
@onready var tile_finder = $tile_finder
@onready var health_manager_var = $player_health_manager
@onready var animations = $animations
@onready var steps = $steps
@onready var timer = $Timer
@onready var other = $other
var shooting_sound = preload("res://Assets/SFX/Player/shoot_ball.wav")
var slow_down_sound = preload("res://Assets/SFX/Player/slow_down.wav")

#scenes
var ball = preload("res://Nodes/Entity nodes/Player/ball.tscn")
func _ready():
	stamina = max_stamina
	SPEED = default_speed
func _process(delta: float) -> void:
	
	if boost_cooldown > -1:
		boost_cooldown -= delta
		
		
	

func _physics_process(delta: float) -> void:
	
	boost_ball()
	
	handle_movement()
	
	handle_direction()
	
	handle_shooting()
	
	move_and_slide()
	
	handle_animations()
	
	handle_stamina(delta)

func handle_movement():
#defineix la direcció segons la rotació i després canvia la velocitat segons l'input i com de molt mira en certa direcció
	direction = Vector2(cos(rotation), sin(rotation))
	
	var hor_input = Input.get_axis("left", "right")
	var ver_input = Input.get_axis("down", "up")
	
	
	if ver_input:
		velocity.x = move_toward(velocity.x, SPEED*ver_input*direction.x, ACCELERATION)
		velocity.y = move_toward(velocity.y, SPEED*ver_input*direction.y, ACCELERATION)
	elif !hor_input and !ver_input:
		velocity.y = move_toward(velocity.y, 0, DECELERATION)
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
	
	if hor_input:
		velocity.x = move_toward(velocity.x, SPEED*hor_input*-direction.y, ACCELERATION)
		velocity.y = move_toward(velocity.y, SPEED*hor_input*direction.x, ACCELERATION)
	elif !hor_input and !ver_input:
		velocity.y = move_toward(velocity.y, 0, DECELERATION)
		velocity.x = move_toward(velocity.x, 0, DECELERATION)

func handle_direction():
	#mira cap al mouse amb una formula de suavitzament
	rotation_smoothing = lerp(rotation_smoothing, get_global_mouse_position(), 0.15 )
	look_at(rotation_smoothing)

func handle_shooting():
	#si els temps de refredament estan be i ha agafat una pilota, utilitza l'input i crea una instancia de bolla
	if Input.is_action_just_pressed("Rclick") and boost_cooldown <= 0 and has_ball == true:
		var ball_instance = ball.instantiate()
		get_parent().add_child(ball_instance)
		ball_instance.global_position = shot_point.global_position
		ball_instance.velocity = direction*ball_instance.initial_speed
		ball_instance.rotation = rotation
		ball_instance.damage *= ball_damage_multiplier
		ball_instance.update_damage()
		has_ball = false
		other.stream = shooting_sound
		other.play
	
func boost_ball():
	#activa la colisió per fer un rebot des del jugador
	if Input.is_action_just_pressed("Lclick") and boost_cooldown <= 0:
		attack_box_collision.disabled = false
		boost_cooldown = 0.3
		
	if boost_cooldown <= 0.1 and attack_box_collision.disabled == false:
		
		attack_box_collision.disabled = true

func _on_catching_box_area_entered(area):
	#retira la bolla al agafar-la
	if area is catchable_box:
		area.die()
		has_ball = true

func _on_bounce_box_area_entered(area):
	#fa un rebot artificial
	if area is catchable_box:
		area.bounce_boost *= bounce_boost_multiplier
		area.bounce_off(Vector2(cos(rotation), sin(rotation)))
		
func handle_animations():
	#canvia l'animació segons si té la pilota i si s'esta movent
	if has_ball == true:
		if velocity != Vector2(0, 0):
			animations.play("run_with_ball")
		else:
			animations.play("idle_with_ball")
	else:
		if velocity != Vector2(0, 0):
			animations.play("run_no_ball")
		else:
			animations.play("idle_no_ball")

func handle_stamina(delta : float):
	#si te prou stamina i pitja l'input alenteix el temps
	if Input.is_action_just_pressed("e") and is_in_slowed_mode == false and stamina >= 0:
		other.stream = slow_down_sound
		other.play()
		await get_tree().create_timer(0.1).timeout
		is_in_slowed_mode = true
		
		
		
	if Input.is_action_just_pressed("e") and is_in_slowed_mode == true:
		
		await get_tree().create_timer(0.05).timeout
		is_in_slowed_mode = false

	#surt forçosament del temps alentit en quedar-se sense stamina
	if stamina <= 0:
		is_in_slowed_mode = false
	
	if is_in_slowed_mode == true:
		Engine.set_time_scale(0.2)
		stamina -= stamina_depletion_rate * delta
		SPEED = default_speed * 3
		
	else:
		Engine.set_time_scale(1.0)
		SPEED = default_speed
	if is_in_slowed_mode == false and stamina <= max_stamina and stamina >= -1:
		stamina += stamina_recovery_rate* delta


func _on_timer_timeout():
	if velocity != Vector2.ZERO:
		steps.play()
