extends projectile

var acid_spawn = preload("res://Nodes/Entity nodes/Enemies/enemy_attacks/acid.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_colliding()
	handle_lifetime(delta)
	handle_movement()

func _die():
	visible = false
	var acid_spawn_instance = acid_spawn.instantiate()
	get_parent().add_child(acid_spawn_instance)
	acid_spawn_instance.global_position = global_position
	acid_spawn_instance.rotation = rotation
	queue_free()
