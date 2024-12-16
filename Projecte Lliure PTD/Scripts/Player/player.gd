extends CharacterBody2D

class_name player
#constants
var SPEED = 300.0
@export var ACCELERATION = 122.2
@export var DECELERATION = 122.2

#variables
var rotation_smoothing : Vector2
var boost_cooldown = 0.3


var direction : Vector2
var has_ball : bool = true

var ball_damage_multiplier = 1
var bounce_boost_multiplier = 1

#nodes
@export var camera : Camera2D
@onready var shot_point: Marker2D = $ShotPoint
@onready var attack_box_collision = $bounce_box/CollisionShape2D

@onready var catching_box = $Catching_box
@onready var bounce_box = $bounce_box
@onready var hurt_box_var = $hurt_box
@onready var tile_finder = $tile_finder
@onready var health_manager_var = $health_manager


#scenes
var ball = preload("res://Nodes/Entity nodes/Player/ball.tscn")

func _process(delta: float) -> void:
	
	if boost_cooldown > -1:
		boost_cooldown -= delta
		
		
	

func _physics_process(delta: float) -> void:
	
	boost_ball()
	
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
	
	if Input.is_action_just_pressed("Rclick") and boost_cooldown <= 0 and has_ball == true:
		var ball_instance = ball.instantiate()
		get_parent().add_child(ball_instance)
		ball_instance.global_position = shot_point.global_position
		ball_instance.velocity = direction*ball_instance.initial_speed
		ball_instance.rotation = rotation
		ball_instance.damage *= ball_damage_multiplier
		ball_instance.update_damage()
		has_ball = false
	
func boost_ball():
	if Input.is_action_just_pressed("Lclick") and boost_cooldown <= 0:
		attack_box_collision.disabled = false
		boost_cooldown = 0.3
		
	if boost_cooldown <= 0.1 and attack_box_collision.disabled == false:
		
		attack_box_collision.disabled = true



func _on_catching_box_area_entered(area):
	if area is catchable_box:
		area.die()
		has_ball = true
		

		





func _on_bounce_box_area_entered(area):
	if area is catchable_box:
		area.bounce_boost *= bounce_boost_multiplier
		area.bounce_off(Vector2(cos(rotation), sin(rotation)))
		
