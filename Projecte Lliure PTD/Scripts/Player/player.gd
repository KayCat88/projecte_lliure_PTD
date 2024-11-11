extends CharacterBody2D

#constants
var SPEED = 1000.0
@export var ACCELERATION = 100
@export var DECELERATION = 100

#variables
var rotation_smoothing : Vector2
var attack_cooldown = 0.5
var health = 10


var movement_rotational_offset : Vector2
var damage = 1

#nodes
@export var camera : Camera2D
@onready var shot_point: Marker2D = $ShotPoint


@onready var offset: Marker2D = $Offset



#scenes


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
	movement_rotational_offset = offset.global_position - position
	
	var hor_input = Input.get_axis("left", "right")
	var ver_input = Input.get_axis("down", "up")
	print(movement_rotational_offset)
	
	if ver_input:
		print(ver_input)
		velocity.x = move_toward(velocity.x, SPEED*ver_input*movement_rotational_offset.x, ACCELERATION)
		velocity.y = move_toward(velocity.y, SPEED*ver_input*movement_rotational_offset.y, ACCELERATION)
	elif !hor_input and !ver_input:
		velocity.y = move_toward(velocity.y, 0, DECELERATION)
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
	
	if hor_input:
		velocity.x = move_toward(velocity.x, SPEED*hor_input*-movement_rotational_offset.y, ACCELERATION)
		velocity.y = move_toward(velocity.y, SPEED*hor_input*movement_rotational_offset.x, ACCELERATION)
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
		
		#var bullet_instance = bullet.instantiate()
		#get_parent().add_child(bullet_instance)
		#bullet_instance.global_position = shot_point.global_position
		#bullet_instance.rotation = rotation
		#bullet_instance.scale = Vector2(size, size)
		#bullet_instance.direction = movement_rotational_offset
		
		
		
		


		
		
		
		




func handle_death():
	
	if health <= 0:
		visible = false
		
		
