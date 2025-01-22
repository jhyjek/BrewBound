extends Panel

class_name ItemStackUI

@onready var ItemSprite : Sprite2D = $Item
@onready var amountLabel: Label = $Label

var inventorySlot : InventorySlot

func update():
	if !inventorySlot || !inventorySlot.item: 
		return
	ItemSprite.visible = true
	ItemSprite.texture = inventorySlot.item.texture
	
	if inventorySlot.amount > 1:
		amountLabel.visible = true
		amountLabel.text = str(inventorySlot.amount)
	else:
		amountLabel.visible = false
