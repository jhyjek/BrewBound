extends Control

@onready var inv: Inv = preload("res://Inventory/Player_Inventory.tres")
@onready var slots: Array = $GridContainer.get_children()

func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])
	
func _ready() -> void:
	update_slots()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visible = true
