extends CharacterBody2D
const speed = 100

# Animate player
var current_dir = "none" #start off going no dir

func _physics_process(delta):
	player_movement(delta)  # Call the player mvmt f(x) below
	
func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"  #add current dir variable to each dir
		play_anim(1)  #call animation f(x0 defined below - 1 means moving
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:  # If nothing is pressed, stand still
		play_anim(0) # 0 means not moving
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
		
#Animate character with this f(x)
func play_anim(movement):
	var dir = current_dir #refer to current dir locally
	var anim = $AnimatedSprite2D #get this sprite
	
	#Set animations to play at the right time
	if dir == "right":
		anim.flip_h = false  #don't flip image
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true  #flip image
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "down":
		anim.flip_h = true  #don't flip image
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	if dir == "up":
		anim.flip_h = true  #don't flip image
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")

