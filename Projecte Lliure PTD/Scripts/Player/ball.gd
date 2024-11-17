extends CharacterBody2D


var initial_speed = 150
var speed_loss = 15
var speed : float
var direction : Vector2
# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	speed = initial_speed
	
func _physics_process(delta):
	handle_movement()
	move_and_slide()
	handle_bounces()
	
func handle_movement():
	direction = Vector2(cos(rotation), sin(rotation))
	velocity.x = speed*direction.x
	velocity.y = speed*direction.y
	
func handle_bounces():
	pass





func _on_area_2d_body_entered(body):
	rotation = get_floor_angle()
