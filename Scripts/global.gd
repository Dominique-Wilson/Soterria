extends Node

var player_current_attack = false #is player currently attacking?

var current_scene = "world"
var transition_scene = false

var player_exit_cliffside_pox = 0
var player_exit_cliffside_posy = 0
var player_start_posx = 0
var player_start_posy = 0

func finish_scene_change():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "cliffside"
		else:
			current_scene = "world"
