extends CharacterBody2D


var initial_speed = 300
var speed_loss = 0.8
var speed : float
var direction : Vector2
var damage = 2

@onready var hitbox = $Hitbox
@onready var animation = $animation

@onready var audio_stream_player_2d = $AudioStreamPlayer2D


# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	speed = initial_speed
	
func _physics_process(delta):
	
	move_and_slide()
	handle_bounces(delta)
	#canvia l'animació segons la velocitat
	animation.speed_scale = speed/initial_speed
	
	
	

	
func handle_bounces(delta):
	#maneja les colisions i aplica una formula de rebot i la perdua de velocitat
	var collision = move_and_collide(velocity * delta)
	if collision:
		audio_stream_player_2d.play()
		velocity = velocity.bounce(collision.get_normal())
		rotation_degrees *= cos(velocity.x)**-1
		velocity.x *= speed_loss
		velocity.y *= speed_loss
		speed *= speed_loss
		update_damage()
func update_damage():
	#canvia el mal segons la velocitat
	hitbox.damage = speed/initial_speed * damage
