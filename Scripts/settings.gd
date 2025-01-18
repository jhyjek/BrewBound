extends Control

@onready var volume_label = $Label
@onready var volume_slider = $MarginContainer/VBoxContainer/Volume


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	volume_slider.value_changed.connect(_on_volume_value_changed)
	_on_volume_value_changed(volume_slider.value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)
	if value == -30: AudioServer.set_bus_volume_db(0,-1000)
	volume_label.text = str(value)
		
	


func _on_texture_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)
