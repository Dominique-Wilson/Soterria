extends Area2D

var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true) #keep arrow on top lvl of game - always visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#change position of arrow (move speed +) and infinite speed as above
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta

func arrow_deal_damage():
	pass

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
