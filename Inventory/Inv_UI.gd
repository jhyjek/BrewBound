extends Control

@onready var inv: Inv = preload("res://Inventory/Player_Inventory.tres")
@onready var itemStackUIClass = preload("res://Inventory/ItemStackUI.tscn")
@onready var slots: Array = $GridContainer.get_children()

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		var InventorySlot: InvSlot = inv.slots[i]
		
		if !InventorySlot.item: continue
		
		var itemStackUI: ItemStackUI = slots[i].itemStackUI
		if !itemStackUI:
			itemStackUI = itemStackUIClass.instantiate()
			slots[i].add_child(itemStackUI) 
			
		itemStackUI.InventorySlot = InventorySlot
		itemStackUI.update()
	
func _ready() -> void:
	ConnectSlots()
	inv.update.connect(update_slots)
	visible = true
	update_slots()
	
func ConnectSlots():
	for slot in slots:
		var callable = Callable(OnSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func OnSlotClicked(slot):
	pass
