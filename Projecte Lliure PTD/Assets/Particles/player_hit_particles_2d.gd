extends GPUParticles2D

var life = 0.5
@export var subparticles1 : Node2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#revisa si té subparticules i maneja el temps de vida
	if subparticles1 != null:
		subparticles1.emitting = true
		
	life -= delta
	if life <= 0:
		queue_free()
