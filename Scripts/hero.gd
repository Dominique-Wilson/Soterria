extends CharacterBody2D

var speed = 100

var player_state

#Inventory
@export var inv: Inv

#abilit to shoot arrow
var bow_equipped = false
var bow_cooldown = true
var arrow = preload("res://Scenes/Combat/arrow.tscn")
var mouse_loc_from_player = null


func _physics_process(delta):
	#how far mouse is from player
	mouse_loc_from_player = get_global_mouse_position() - self.position
	
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("e"):
		if bow_equipped:
			bow_equipped = false
		else:
			bow_equipped = true
	
	#shoot arrow ar marker2d to rls into world
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos) #marker looks as mouse position
	
	if Input.is_action_just_pressed("left_mouse") and bow_equipped and bow_cooldown:
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation #where arrow aims
		arrow_instance.global_position = $Marker2D.global_position #where arrow spawns
		add_child(arrow_instance) #load into scene + shoot one arrow only
		
		await get_tree().create_timer(0.4).timeout
		bow_cooldown = true
		
	
	play_anim(direction)

func play_anim(dir):
	if !bow_equipped:
		speed = 100
		#Walk in cardinal directions
		if player_state == "idle":
			$AnimatedSprite2D.play("idle")
		if player_state == "walking":  #create 4-dir walk anim
			if dir.y == -1:
				$AnimatedSprite2D.play("n_walk")
			if dir.x == 1:
				$AnimatedSprite2D.play("e_walk")
			if dir.y == 1:
				$AnimatedSprite2D.play("s_walk")
			if dir.x == -1:
				$AnimatedSprite2D.play("w_walk")
			
			#Diagonal walking animations
			if dir.x > 0.5 and dir.y < -0.5:
				$AnimatedSprite2D.play("ne_walk")
			if dir.x > 0.5 and dir.y > 0.5:
				$AnimatedSprite2D.play("se_walk")
			if dir.x < -0.5 and dir.y > 0.5:
				$AnimatedSprite2D.play("sw_walk")
			if dir.x < -0.5 and dir.y < -0.5:
				$AnimatedSprite2D.play("nw_walk")
	if bow_equipped:
		speed = 0
		if mouse_loc_from_player.x >= -25 and mouse_loc_from_player.x <= 25 and mouse_loc_from_player.y < 0:
			$AnimatedSprite2D.play("n_attack")
		if mouse_loc_from_player.y >= -25 and mouse_loc_from_player.y <= 25 and mouse_loc_from_player.x > 0:
			$AnimatedSprite2D.play("e_attack")
		if mouse_loc_from_player.x >= -25 and mouse_loc_from_player.x <= 25 and mouse_loc_from_player.y > 0:
			$AnimatedSprite2D.play("s_attack")
		if mouse_loc_from_player.y >= -25 and mouse_loc_from_player.y <= 25 and mouse_loc_from_player.x < 0:
			$AnimatedSprite2D.play("w_attack")
			
		if mouse_loc_from_player.x >= 25 and mouse_loc_from_player.y <= -25:
			$AnimatedSprite2D.play("ne_attack")
		if mouse_loc_from_player.x >= 0.5 and mouse_loc_from_player.y >= 25:
			$AnimatedSprite2D.play("se_attack")
		if mouse_loc_from_player.x <= -0.5 and mouse_loc_from_player.y >= 25:
			$AnimatedSprite2D.play("sw_attack")
		if mouse_loc_from_player.x <= -25 and mouse_loc_from_player.y <= -25:
			$AnimatedSprite2D.play("nw_attack")
		
func player():
	pass

#Collect pickable item by calling this f(x) for items picked
func collect(item):
	inv.insert(item)  #called from export var
