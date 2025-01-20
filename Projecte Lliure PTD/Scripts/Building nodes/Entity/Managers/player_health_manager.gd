extends health_manager


@onready var timer = $Timer
var has_died = false


func _die():
	 
	if has_died == false:
		timer.start()
		has_died = true
		get_parent().visible = false


#player-> world-> game_master
func _on_timer_timeout():
	get_parent().get_parent().get_parent().load_menu()
	
