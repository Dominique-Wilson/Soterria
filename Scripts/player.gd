extends CharacterBody2D

var enemy_inattack_range = false  #if enemy within range
var enemy_attack_cooldown = true  #quick cool-down period
var health = 120
var player_alive = true

var attack_ip = false  #attack in progress

const speed = 120

# Animate player
var current_dir = "none" #start off going no dir

#enable movement on start of game
func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)  # Call the player mvmt f(x) below
	enemy_attack()
	play_attack()
	
	if health <= 0:
		player_alive = false # player diesrespawn or go back to level begin etc
		health = 0
		print("player has been killed")
		self.queue_free()  #delete player
		
	
func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"  #add current dir variable to each dir
		play_anim(1)  #call animation f(x) defined below - 1 means is moving
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
			if attack_ip == false:
				anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true  #flip image
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
	if dir == "down":
		anim.flip_h = true  #don't flip image
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("front_idle")
	if dir == "up":
		anim.flip_h = true  #don't flip image
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("back_idle")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
func play_attack():   #attack animation
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):  #one press to attack
		global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$MageBlast.play("orb_blast")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$MageBlast.play("orb_blast")
			$deal_attack_timer.start()
		if dir == "down":
			$MageBlast.play("orb_blast")
			$deal_attack_timer.start()
		if dir == "up":
			$MageBlast.play("orb_blast")
			$deal_attack_timer.start()



func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
