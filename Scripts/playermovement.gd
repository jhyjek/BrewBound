extends CharacterBody2D

@onready var animation = $AnimationPlayer
@onready var player_sprite = $Sprite2D

@export var inventory : Inventory

const SPEED = 110.0
const JUMP_VELOCITY = -275.0




func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if velocity.x < 0:
		player_sprite.flip_h = true
	elif  velocity.x > 0:
		player_sprite.flip_h = false

	# Handle jump.
	if (Input.is_action_just_pressed("space") or Input.is_action_just_pressed("W")) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("A", "D")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	handle_animation()

func handle_animation():
	if is_on_floor():
		if velocity:
			animation.play("walk")
		else:
			animation.play("idle")
	else:
		animation.play("jump")

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.has_method("collect"):
		area.collect(inventory)
