extends CharacterBody2D

@export var inv: Inv

const SPEED = 150.0
const JUMP_VELOCITY = -275.0
@onready var animation = $AnimationPlayer
func collect(item):
	inv.insert(item)

func _physics_process(delta: float) -> void:
	# Add the gravity.
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
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle") 

	move_and_slide()
