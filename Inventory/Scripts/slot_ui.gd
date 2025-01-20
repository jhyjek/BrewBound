extends Panel

@onready var BackGroundSprite : Sprite2D = $BackGround
@onready var ItemSprite : Sprite2D = $CenterContainer/Panel/Item

func update(item : InventoryItem):
	if !item:
		ItemSprite.visible = false
	else:
		ItemSprite.visible = true
		ItemSprite.texture = item.texture
