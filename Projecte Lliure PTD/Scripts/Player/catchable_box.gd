extends Area2D

class_name catchable_box
@onready var collision_shape_2d = $CollisionShape2D
var disabled_timer = 0.3
var redirection_strenght = 300
var bounce_boost = 2
# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if disabled_timer > 0:
		disabled_timer -= delta
	else:
		collision_shape_2d.disabled = false
	
func die():
	get_parent().queue_free()
func bounce_off(collision : Vector2):
	get_parent().velocity = get_parent().velocity.bounce(collision)
	get_parent().velocity *= 0.5
	get_parent().rotation_degrees *= cos(get_parent().velocity.x)**-1
	get_parent().velocity.x = redirection_strenght*collision.x
	get_parent().velocity.y = redirection_strenght*collision.y
	get_parent().velocity.x *= bounce_boost
	get_parent().velocity.y *= bounce_boost
	
