extends CollisionShape2D

@export var item:Inv_Items
var player = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player = body
		player.collect(item)
		queue_free()
