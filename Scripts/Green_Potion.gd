extends CollisionShape2D

@export var item:Inv_Items
var player = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body is CharacterBody2D:
		print('dawjkh')
		player = body
		player.collect(item)
