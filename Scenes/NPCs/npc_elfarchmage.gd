extends CharacterBody2D

const speed = 30
var current_state = IDLE

var dir #Vector2.ZERO #prev right
var start_pos

#var is_roaming = false #disabled roaming
var is_chatting = false

var player
var player_in_chat_zone = false
var the_player

var quest_completed = false #track quest completion

enum {
	IDLE
	#NEW_DIR,
	#MOVE
}

func _ready():
	#randomize()
	start_pos = position
	the_player = get_parent().get_node("hero")
	

func _process(delta):
	if current_state == IDLE: #or current_state == NEW_DIR: #prev 0, 1
		$AnimatedSprite2D.play("idle")
	
	#remove roaming code for now...
	#elif current_state == 2 and !is_chatting:
	#	if dir.x == -1: 
	#		$AnimatedSprite2D.play("w_walk")
	#	if dir.x == 1:
	#		$AnimatedSprite2D.play("e_walk")
	#	if dir.y == -1:
	#		$AnimatedSprite2D.play("n_walk")
	#	if dir.y == 1:
	#		$AnimatedSprite2D.play("s_walk")
	
	#change dir when npc roams	
	#if is_roaming:
	#	match current_state:
	#		IDLE:
	#			pass
	#		NEW_DIR:
	#			dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
	#		MOVE:
	#			move(delta)
	if Input.is_action_just_pressed("chat"):
		$first_dialogue.start()
		#is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("idle")
	if Input.is_action_just_pressed("quest"):
		$npc1_quest.next_quest()
		#is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("idle")
	
	if quest_completed:
		move_npc_to_player(delta)
		
func on_quest_completed():
	quest_completed = true
	#give_wand()

func move_npc_to_player(delta):
		dir = (the_player.position - position).normalized()
		#position = the_player.position
		position += dir * speed * delta
	
#func give_wand():
	#var wand = preload(FPATH).instance()
	#player.add_child(wand)

#func choose(array):
#	array.shuffle()
#	return array.front()

#func move(delta):
#	if !is_chatting:
#		position += dir * speed * delta
		#velocity = dir * speed #these 2 lines alternative for collision
		#move_and_slide()

func _on_chat_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true

func _on_chat_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_chat_zone = false

#func _on_timer_timeout():
#	$Timer.wait_time = choose([0.5, 1, 1.5])
#	current_state = choose([IDLE, NEW_DIR, MOVE])


func _on_first_dialogue_dialogue_finished():
	is_chatting = false
	#is_roaming = true


func _on_npc_1_quest_quest_menu_closed():
	is_chatting = false
	#is_roaming = true


func _on_hero_stick_collected():
	$npc1_quest.stick_collected()

func _on_hero_peridot_collected():
	$npc1_quest.peridot_collected()
