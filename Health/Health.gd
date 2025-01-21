class_name Health 
extends Node

signal max_health_changed(diff: int)
signal health_changed(diff: int )
signal health_depleted 

@export var Maxhealth: int = 3 : set = set_max_health, get = get_max_health
@export var immortality: bool = false : set = set_immortality, get = get_immortality
var immortalTimer: Timer = null

@onready var health: int = Maxhealth 

func set_max_health(value: int):
	var clamped_value = 1 if value <= 0 else value 
	
	if not clamped_value == Maxhealth:
		var difference = clamped_value - Maxhealth	
		Maxhealth = value 
		max_health_changed.emit(difference)
		
		if health > Maxhealth:
			health = Maxhealth
			
func get_max_health() -> int:
	return Maxhealth
	
func set_immortality(value: bool):
	immortality = value
	
func set_immortality_timer(time: float):
	if immortalTimer == null: 
		immortalTimer = Timer.new()
		immortalTimer.one_shot = true 
		add_child(immortalTimer)
		
	if immortalTimer.timeout.is_connected(set_immortality):
		immortalTimer.timeout.disconnect(set_immortality)
		
	immortalTimer.set_wait_time(time)
	immortalTimer.timeout.connect(set_immortality.bind(false))
	immortality = true 
	immortalTimer.start()
	
func get_immortality() -> bool: 
	return immortality
	
func setHealth(value: int):
	if value < health and immortality:
		return 
	var clamped_value = clampi(value, 0, Maxhealth )
	
	if clamped_value != health:
		var difference = clamped_value - health 
		health = value 
		health_changed.emit(difference)
		
		if health == 0:
			health_depleted.emit()
