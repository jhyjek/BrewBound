extends Control

signal opened
signal closed

var isOpen : bool = false;

@onready var inventory : Inventory = preload("res://Inventory/PlayerInventory.tres")
@onready var ItemStackUIClass = preload("res://Inventory/Scenes/ItemStackUI.tscn")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()

var itemInHand: ItemStackUI

func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()

func connectSlots():
	for slot in slots:
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		
		if !inventorySlot.item: continue
		
		var itemStackUI : ItemStackUI = slots[i].itemStackUI
		if !itemStackUI:
			itemStackUI = ItemStackUIClass.instantiate()
			slots[i].insert(itemStackUI)
			
		itemStackUI.inventorySlot = inventorySlot
		itemStackUI.update()

func open():
	visible = true
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false
	closed.emit()

func onSlotClicked(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	

	
