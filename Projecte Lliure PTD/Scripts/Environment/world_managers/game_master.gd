extends Node
class_name game_master

#serveixen per ajustar la dificultat
var room_number : int
var zone_number : int

#els nodes que s'hauran d'emprar en algun moment
var main_menu_node : Control
var world_node : Node2D

var main_menu = preload("res://Nodes/Entity nodes/UI/main_menu.tscn")
var world = preload("res://Nodes/Entity nodes/Environment/world.tscn")
var tutorial = preload("res://Nodes/Scene nodes/Levels/tutorial.tscn")
var credits = preload("res://Nodes/Entity nodes/UI/credits.tscn")

#les estadistiques que s'hauran de modificar
var player_health_multiplier = 1
var player_stamina_multiplier = 1
var player_damage_multiplier = 1
var player_boost_multiplier = 1

@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func _ready():
	load_menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#maneja la dificultat i té en compte l'input del menú
	zone_number = ((room_number-1)/5) + 1
	if Input.is_action_just_pressed("menu"):
		load_menu()

func load_run():
	#fa net els fills i crea una instancia de partida
	audio_stream_player_2d.play()
	clear_multipliers()
	clear_children()
	room_number = 1
	var world_instance = world.instantiate()
	add_child(world_instance)
	world_instance.room_number = room_number
	world_instance.zone_number = zone_number

func load_menu():
#fa net els fills i crea una instancia de menu
	audio_stream_player_2d.play()
	clear_multipliers()
	clear_children()
	var main_menu_instance = main_menu.instantiate()
	add_child(main_menu_instance)
	
func load_tutorial():
#fa net els fills i crea una instancia de tutorial
	audio_stream_player_2d.play()
	clear_children()
	var tutorial_instance = tutorial.instantiate()
	add_child(tutorial_instance)
	
func load_credits():
#fa net els fills i crea una instancia de credits
	audio_stream_player_2d.play()
	clear_children()
	var credits_instance = credits.instantiate()
	add_child(credits_instance)
	
func new_level():
#crea la següent habitació, afegint un nombre més a l'habitació per ajustar la dificultat, creant l'habitació i establint els valors del jugador segons les fruites trobades
	clear_children()
	room_number += 1
	var world_instance = world.instantiate()
	add_child(world_instance)
	world_instance.room_number = room_number
	world_instance.zone_number = zone_number
	world_instance.player_node.health_manager_var.max_health *= player_health_multiplier
	world_instance.player_node.health_manager_var.health *= player_health_multiplier
	world_instance.player_node.ball_damage_multiplier *= player_damage_multiplier
	world_instance.player_node.max_stamina *= player_stamina_multiplier
	world_instance.player_node.bounce_boost_multiplier *= player_boost_multiplier

func clear_children():
#elimina tots els nodes que no siguin el reproductor d'audio
	for child in get_children():
		if child is AudioStreamPlayer2D:
			continue
		else:
			remove_child(child)
		
func clear_multipliers():
#torna les estadistiques del jugador al seu estat normal
	player_boost_multiplier = 1
	player_damage_multiplier = 1
	player_health_multiplier = 1
	player_stamina_multiplier = 1
