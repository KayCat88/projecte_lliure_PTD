extends Label

@export var player_health : health_manager
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_health.health >= 0:
		text = str(int(player_health.health)) + "/" + str(player_health.max_health)
	
