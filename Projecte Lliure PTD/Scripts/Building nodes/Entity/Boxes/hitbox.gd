extends Area2D
class_name hit_box

@export var damage : float = 1
@export var collider : CollisionShape2D
@export var damage_cooldown : float = 0.1
@export var damage_cooldown_setter : float = 0.1
var found_hurt_box : hurt_box
var can_hurt : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if damage_cooldown >= 0:
		damage_cooldown -= delta
		can_hurt = false
	else:
		can_hurt = true


func hit_box_on_area_entered(area):
	#revisa si no té ja una hitbox a la que ja s'estigui aplicant mal i si es aixi i es troba davant una hurtbox l'estableix fins que en surti (on area exited) i aplica el mal i la posició des de que es fa
	if area is hurt_box and found_hurt_box == null and can_hurt == true:
		found_hurt_box = area
		found_hurt_box.send_damage(damage, global_position)
		damage_cooldown = damage_cooldown_setter
		




func _on_area_exited(area):
	
	found_hurt_box = null
