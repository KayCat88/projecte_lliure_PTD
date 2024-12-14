extends CharacterBody2D


var initial_speed = 300
var speed_loss = 0.8
var speed : float
var direction : Vector2
var damage = 2

@onready var hitbox = $Hitbox


# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	speed = initial_speed
	
func _physics_process(delta):
	
	move_and_slide()
	handle_bounces(delta)
	
	print(hitbox.damage)
	
	

	
func handle_bounces(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		rotation_degrees *= cos(velocity.x)**-1
		velocity.x *= speed_loss
		velocity.y *= speed_loss
		speed *= speed_loss
		update_damage()
func update_damage():
	hitbox.damage = speed/initial_speed * damage
