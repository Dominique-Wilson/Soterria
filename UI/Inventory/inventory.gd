extends Resource

class_name Inv

#in order to insert apples to inv, must call ea slot
signal update

#create array to store items
@export var slots: Array[InvSlot]

func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():  #if slot open
		itemslots[0].amount += 1  #increment by 1 if not open -> pick next
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1 #first item collected
	update.emit() #update slot UI
