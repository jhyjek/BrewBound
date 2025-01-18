extends Control

@onready var inv: Inv = preload("res://Inventory/Player_Inventory.tres")
@onready var slots: Array = $GridContainer.get_children()

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	
func _ready() -> void:
	visible = true
	update_slots()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	inv.update.connect(update_slots)
