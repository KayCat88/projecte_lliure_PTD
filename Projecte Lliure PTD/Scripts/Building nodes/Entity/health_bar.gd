extends TextureProgressBar

@export var entity_health : health_manager
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = entity_health.health/entity_health.max_health * 100
