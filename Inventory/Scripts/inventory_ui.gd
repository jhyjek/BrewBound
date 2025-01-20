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
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		
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
	if slot.isEmpty() && itemInHand:
		insertItemInSlot(slot)
		return
	if!itemInHand:
		takeItemFromSlot(slot)
	
func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()
	
func insertItemInSlot(slot):
	var item = itemInHand
	
	remove_child(itemInHand)
	itemInHand = null
	
	slot.insert(item)
	
func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size / 2
	
func _input(event):
	updateItemInHand()
	
