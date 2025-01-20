extends Button

@onready var BackGroundSprite : Sprite2D = $BackGround
@onready var container: CenterContainer = $CenterContainer

var itemStackUI: ItemStackUI

func insert(isg: ItemStackUI):
	itemStackUI = isg
	container.add_child(itemStackUI)
	
func takeItem():
	var item = itemStackUI
	
	container.remove_child(itemStackUI)
	itemStackUI = null
	
	return item
