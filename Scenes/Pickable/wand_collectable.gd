extends StaticBody2D

@export var item: InvItem
var player = null

var is_visible_after_quest = false

func _ready():
	position = Vector2(271, 142)
	hide() #initially invisible
	var quest_node = get_node("/root/world/npc_elfarchmage/npc1_quest")
	quest_node.connect("quest1_complete", Callable(self, "_on_quest_completed"))

func _on_quest_completed():
	is_visible_after_quest = true
	show()

func _on_interactable_area_body_entered(body):
	if is_visible_after_quest and body.has_method("player"):
		player = body
		playercollect()
		await get_tree().create_timer(0.1).timeout
		self.queue_free()
		
func playercollect():
	if is_visible_after_quest:
		player.collect(item)
