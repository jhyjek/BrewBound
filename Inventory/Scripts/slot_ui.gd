extends Button

@onready var BackGroundSprite : Sprite2D = $BackGround
@onready var container: CenterContainer = $CenterContainer

@onready var inventory = preload("res://Inventory/PlayerInventory.tres")

var itemStackUI: ItemStackUI
var index: int

func insert(isg: ItemStackUI):
	itemStackUI = isg
	container.add_child(itemStackUI)
	
	if !itemStackUI.inventorySlot || inventory.slots[index] == itemStackUI.inventorySlot:
		return
	inventory.insertSlot(index, itemStackUI.inventorySlot)
	
func takeItem():
	var item = itemStackUI
	
	container.remove_child(itemStackUI)
	itemStackUI = null
	
	return item
	
func isEmpty():
	return !itemStackUI
