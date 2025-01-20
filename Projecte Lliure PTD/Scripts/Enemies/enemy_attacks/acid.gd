extends Area2D

@export var damage : float = 1
@export var collider : CollisionShape2D
var damage_cooldown : float = 0.1
@export var damage_cooldown_setter : float = 0.1
@export var lifetime = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#revisa si s'ha acabat el temps d'existencia
	if lifetime <= 0:
		queue_free()
	else:
		lifetime -= delta
	#revisa si pot tornar a aplicar mal
	if damage_cooldown >= 0:
		damage_cooldown -= delta
		collider.disabled = true
	else:
		collider.disabled = false



func _on_area_entered(area):
	#revisa si ha trobat una hurt box i envia el mal
	if area is hurt_box:
		area.send_damage(damage, global_position)
		damage_cooldown = damage_cooldown_setter
