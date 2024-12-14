extends Node2D

var assist_strenght : float = 10
var enemy_selected : enemy
@export var ball : CharacterBody2D
var dir : Vector2
var raycast_set : Array[RayCast2D]
@onready var up_raycast = $up_raycast
@onready var up_mid_raycast = $up_mid_raycast
@onready var mid_raycast = $mid_raycast
@onready var down_mid_raycast = $down_mid_raycast
@onready var down_raycast = $down_raycast
var raycast_check : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	raycast_set = [up_raycast, up_mid_raycast, mid_raycast, down_mid_raycast, down_raycast]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	redirect()
	search_for_enemies()


	
func search_for_enemies():
	
	
	for raycast in raycast_set:
		
		if raycast.get_collider() is enemy:
			raycast_check = 5
			enemy_selected = raycast.get_collider()
			
		else:
			raycast_check -= 1
	if raycast_check <= 0:
		enemy_selected = null
	
func redirect():
	
	if enemy_selected != null:
		dir = Vector2(enemy_selected.global_position.x - ball.global_position.x, enemy_selected.global_position.y - ball.global_position.y).normalized()
		#ball.velocity = dir * ball.speed
		#ball.global_position.x = move_toward(ball.global_position.x, enemy_selected.global_position.x, assist_strenght)
		#ball.global_position.y = move_toward(ball.global_position.y, enemy_selected.global_position.y, assist_strenght)
		ball.velocity.x = move_toward(ball.velocity.x, (dir * ball.speed).x, (assist_strenght/ball.initial_speed)*ball.speed)
		ball.velocity.y = move_toward(ball.velocity.y, (dir * ball.speed).y, (assist_strenght/ball.initial_speed)*ball.speed)
		

# Replace with function body.
