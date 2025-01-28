extends Button

@onready var background_sprite : Sprite2D = $BackGround
@onready var item_stack_ui : ItemStackUI = $CenterContainer/Panel

func update_to_slot(slot:InventorySlot) -> void:
	if !slot.item:
		item_stack_ui.visible = false
		return
	item_stack_ui.inventorySlot = slot
	item_stack_ui.update()
	item_stack_ui.visible = true
	
