extends Button

@onready var centerContainer = $CenterContainer
@onready var BackgroundSprite: Sprite2D = $Sprite2D

var itemStackUI:ItemStackUI

func insert(isg : ItemStackUI):
	itemStackUI = isg
	BackgroundSprite.frame = 1
	centerContainer.add_child(itemStackUI)

func TakeItem():
	var item = itemStackUI
	
	centerContainer.remove_child(itemStackUI)
	itemStackUI = null
	BackgroundSprite.frame = 0
	
	return item
