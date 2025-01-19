extends Control

@onready var inv: Inv = preload("res://Inventory/Player_Inventory.tres")
@onready var itemStackUIClass = preload("res://Inventory/ItemStackUI.tscn")
@onready var slots: Array = $GridContainer.get_children()

var ItemInHand: ItemStackUI

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
	if slot.IsEmpty() && ItemInHand:
		InsertItemInSlot(slot)
		return
	if !ItemInHand:
		TakeItemFromSlot(slot)
	
func TakeItemFromSlot(slot):
	ItemInHand = slot.TakeItem()
	add_child(ItemInHand)
	UpdateItemInHand()

func InsertItemInSlot(slot):
	var item = ItemInHand
	
	remove_child(ItemInHand)
	ItemInHand = null
	
	slot.insert(item)

func UpdateItemInHand():
	if !ItemInHand: 
		return
	ItemInHand.global_position = get_global_mouse_position() - ItemInHand.size / 2
	print("cool")

func _input(event):
	UpdateItemInHand()
