extends CharacterBody2D

@export var move_speed : float = 100

#move the player
func _physics_process(_delta):
	#Get input direction
	var input_direction = Vector2( #take x, y coord's
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
		
	#Update velocity (dir x speed)
	velocity = input_direction * move_speed
	
	#Move and slide f(x) uses velocity of char body to move char on map
	move_and_slide() #slides char against wall instead of stopping on collision
