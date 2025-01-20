extends Panel

@onready var BackGroundSprite : Sprite2D = $BackGround
@onready var ItemSprite : Sprite2D = $CenterContainer/Panel/Item
@onready var amountLabel: Label = $CenterContainer/Panel/Label

func update(slot : InventorySlot):
	if !slot.item:
		ItemSprite.visible = false
		amountLabel.visible = false
	else:
		ItemSprite.visible = true
		ItemSprite.texture = slot.item.texture
		if slot.amount > 1:
			amountLabel.visible = true
			amountLabel.text = str(slot.amount)
