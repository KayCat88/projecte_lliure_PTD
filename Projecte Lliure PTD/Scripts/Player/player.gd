extends CharacterBody2D

#constants
var SPEED = 1000.0
@export var ACCELERATION = 122.2
@export var DECELERATION = 122.2

#variables
var rotation_smoothing : Vector2
var attack_cooldown = 0.5
var health = 10


var direction : Vector2
var damage = 1

#nodes
@export var camera : Camera2D
@onready var shot_point: Marker2D = $ShotPoint






#scenes
var ball = preload("res://Nodes/Entity nodes/Player/ball.tscn")

func _process(delta: float) -> void:
	
	if attack_cooldown > -2:
		attack_cooldown -= delta
	handle_death()
	

func _physics_process(delta: float) -> void:
	
	if health <= 0:
		health = 0
	
	handle_movement()
	
	handle_direction()
	
	handle_shooting()
	
	move_and_slide()

func handle_movement():
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
	rotation_smoothing = lerp(rotation_smoothing, get_global_mouse_position(), 0.15 )
	look_at(rotation_smoothing)

func handle_shooting():
	
	if Input.is_action_just_pressed("Rclick") and attack_cooldown <= 0:
		
		attack_cooldown = 0.5
		await  get_tree().create_timer(0.3).timeout
		
		var ball_instance = ball.instantiate()
		get_parent().add_child(ball_instance)
		ball_instance.global_position = shot_point.global_position
		ball_instance.velocity = direction*ball_instance.initial_speed
		ball_instance.rotation = rotation
		
		





func handle_death():
	
	if health <= 0:
		visible = false
		
		
