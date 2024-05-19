extends Node2D

var state = "no_apples"
var player_in_area = false

var apple = preload("res://Scenes/Pickable/apple_collectable.tscn")

#what collectable does apple tree drop that is assigned 'item'?
@export var item: InvItem  #define item's resource
var player = null

func _ready(): #grow apples
	if state == "no_apples":
		$growth_timer.start()
		
func _process(delta): #play animations
	if state == "no_apples":
		$AnimatedSprite2D.play("no_apples")
	if state == "apples":
		$AnimatedSprite2D.play("apples")
		#ability to pick apples
		if player_in_area: 
			if Input.is_action_just_pressed("e"):
				state = "no_apples"
				drop_apple()  #call f(x)

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout():
	if state == "no_apples":
		state = "apples"

func drop_apple():
	var apple_instance = apple.instantiate()
	apple_instance.global_position = $Marker2D.global_position #spawn apples on marker 2d
	get_parent().add_child(apple_instance)
	# have player collect apple
	player.collect(item)
	await get_tree().create_timer(3).timeout #3 sec delay before apple falls
	$growth_timer.start()
