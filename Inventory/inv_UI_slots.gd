extends Button

@onready var centerContainer = $CenterContainer

var itemStackUI:ItemStackUI

func insert(isg : ItemStackUI):
	itemStackUI = isg
	centerContainer.add_child(itemStackUI)
