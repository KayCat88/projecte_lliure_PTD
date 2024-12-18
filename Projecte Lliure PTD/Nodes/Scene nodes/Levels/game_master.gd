extends Node
class_name game_master

var room_number : int
var zone_number : int

var main_menu_node : Control
var world_node : Node2D

var main_menu = preload("res://Nodes/Entity nodes/UI/main_menu.tscn")
var world = preload("res://Nodes/Entity nodes/Environment/world.tscn")
var tutorial = preload("res://Nodes/Scene nodes/Levels/tutorial.tscn")
var credits = preload("res://Nodes/Entity nodes/UI/credits.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	load_menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	zone_number = ((room_number-1)/5) + 1
	if Input.is_action_just_pressed("menu"):
		load_menu()

func load_run():
	clear_children()
	room_number = 1
	var world_instance = world.instantiate()
	add_child(world_instance)
	world_instance.room_number = room_number
	world_instance.zone_number = zone_number

func load_menu():
	clear_children()
	var main_menu_instance = main_menu.instantiate()
	add_child(main_menu_instance)
	
func load_tutorial():
	clear_children()
	var tutorial_instance = tutorial.instantiate()
	add_child(tutorial_instance)
	
func load_credits():
	clear_children()
	var credits_instance = credits.instantiate()
	add_child(credits_instance)
	
func new_level():
	clear_children()
	room_number += 1
	var world_instance = world.instantiate()
	add_child(world_instance)
	world_instance.room_number = room_number
	world_instance.zone_number = zone_number

func clear_children():
	for child in get_children():
		remove_child(child)
