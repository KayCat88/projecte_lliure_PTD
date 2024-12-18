extends health_manager





func _die():
	#player-> world-> game_master (he de mirar de trobar una millor manera d'arribar al node pare de l'escena)
	get_parent().get_parent().get_parent().load_menu()
