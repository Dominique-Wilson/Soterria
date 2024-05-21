class_name MainMenu
extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/start_button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer2/exit_button as Button
@export var starting_level = preload("res://Scenes/world.tscn") as PackedScene

func _ready():
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)	
	
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(starting_level)
	
func on_exit_pressed() -> void:
	get_tree().quit()
