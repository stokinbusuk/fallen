extends Area2D

func _on_SpikeLeft_body_entered(body):
	if body.name == "Demon":
		body.health = 0
