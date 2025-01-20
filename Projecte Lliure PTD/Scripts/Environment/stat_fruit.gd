extends Area2D
class_name stat_fruit

@export_range(0, 3) var stat_to_upgrade : int = 0
var stat_list : Array
var stat_upgrade_value_list : Array
var particles = preload("res://Assets/Particles/power_up_particles.tscn")




var health_upgrade_value = 1.15
var stamina_upgrade_value = 1.15
var boost_speed_upgrade_value = 1.5
var damage_upgrade_value = 1.25



# Called when the node enters the scene tree for the first time.
func _ready():
	stat_upgrade_value_list = [health_upgrade_value, stamina_upgrade_value, boost_speed_upgrade_value, damage_upgrade_value]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.

	




func _on_body_entered(body):
#al trobar-se un jugador canvia el valor del game-master sobre com s'hauran de canviar les estadistiques del jugador en futures habitacions.
#el que es canvii es predefineix a l'editor i fa que siguin les diferents fruites
	if body is player:
		var particles_instance = particles.instantiate()
		get_parent().add_child(particles_instance)
		particles_instance.global_position = global_position
		particles_instance.audio_stream_player_2d.play()
		particles_instance.emitting = true
		
		if stat_to_upgrade == 0:
			get_parent().get_parent().player_health_multiplier *= health_upgrade_value
		elif stat_to_upgrade == 1:
			get_parent().get_parent().player_stamina_multiplier *= stamina_upgrade_value
		elif stat_to_upgrade == 2:
			get_parent().get_parent().player_boost_multiplier *= boost_speed_upgrade_value
		elif stat_to_upgrade == 3:
			get_parent().get_parent().player_damage_multiplier *= damage_upgrade_value
		queue_free()
