extends enemy

var damage = 3
@onready var hitbox = $rotator/Hitbox
var attack_cooldown = 2
var bite_particles = preload("res://Assets/Particles/bite_particles_2d.tscn")
@onready var rotator = $rotator

func _ready():
	get_player_info_at_spawn()


func _physics_process(delta):
	
	# Add the gravity.
	set_behavior()
	if attack_cooldown >= 0:
		attack_cooldown -= delta
	
	move_and_slide()
	if can_attack == true and attack_cooldown <= 0:
		attack()
	else:
		hitbox.collider.disabled = true

func attack():
	hitbox.collider.disabled = false
	attack_cooldown = 2
	var bite_particles_instance = bite_particles.instantiate()
	get_parent().add_child(bite_particles_instance)
	bite_particles_instance.global_position = hitbox.global_position
	bite_particles_instance.rotation = rotator.rotation
	bite_particles_instance.emitting = true
