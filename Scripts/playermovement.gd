extends CharacterBody2D

@onready var player_sprite = $Sprite2D
const SPEED = 100.0
const JUMP_VELOCITY = -275.0
@onready var animation = $AnimationPlayer
@onready var crow = preload("res://Visual media/crowidle.png")
@onready var wiz = preload("res://Visual media/wizidle.png")

const Gravity : int = 1000
const  max_vel : int = 600
const flap_speed : int = -500
var crowmode :bool = false




func _process(delta: float) -> void:
	if Input.is_action_just_pressed("E"):
		player_sprite.texture = crow
	
		
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if velocity.x < 0:
		player_sprite.flip_h = true
	elif  velocity.x > 0:
		player_sprite.flip_h = false
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("A", "D")
	if direction:
		velocity.x = direction * SPEED
		animation.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle") 
		
		

	move_and_slide()
