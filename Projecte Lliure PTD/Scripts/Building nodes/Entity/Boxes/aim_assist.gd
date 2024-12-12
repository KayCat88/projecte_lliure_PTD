extends Area2D

var assist_strenght : float = 5
var enemy_selected : enemy
@export var ball : CharacterBody2D
var dir : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	redirect()


func _on_body_entered(body):
	
	if body is enemy:
		
		enemy_selected = body
		
		
func _on_body_exited(body):
	
	enemy_selected = null

func redirect():
	print(enemy_selected)
	if enemy_selected != null:
		dir = Vector2(enemy_selected.global_position.x - ball.global_position.x, enemy_selected.global_position.y - ball.global_position.y).normalized()
		#ball.velocity = dir * ball.speed
		#ball.global_position.x = move_toward(ball.global_position.x, enemy_selected.global_position.x, assist_strenght)
		#ball.global_position.y = move_toward(ball.global_position.y, enemy_selected.global_position.y, assist_strenght)
		ball.velocity.x = move_toward(ball.velocity.x, (dir * ball.speed).x, (assist_strenght/ball.initial_speed)*ball.speed)
		ball.velocity.y = move_toward(ball.velocity.y, (dir * ball.speed).y, (assist_strenght/ball.initial_speed)*ball.speed)
		

# Replace with function body.
