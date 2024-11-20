extends Area2D
class_name hit_box

@export var damage : float = 1
@export var collider : CollisionShape2D
var damage_cooldown = 0.2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if damage_cooldown >= 0:
		damage_cooldown -= delta
		collider.disabled = true
	else:
		collider.disabled = false


func hit_box_on_area_entered(area):
	if area is hurt_box:
		area.send_damage(damage)
		damage_cooldown = 0.2
		
