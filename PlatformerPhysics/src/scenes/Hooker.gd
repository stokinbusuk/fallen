extends KinematicBody2D

var toplay
var useable : bool = false
var already : bool = false
var player

func _ready():
	$AnimationPlayer.stop()
	$Rope.visible = false

func _physics_process(delta):
	if useable:
		player = get_parent().get_node("Demon")
		if player.global_position.x > $Rope.global_position.x and !already:
			toplay = "RotationFromRight"
			already = true
		elif player.global_position.x <= $Rope.global_position.x and !already:
			toplay = "Rotation"
			already = true
		if Input.is_action_pressed("ui_accept"):
				already = true
				$Rope.visible = true
				$AnimationPlayer.play(toplay)
				player.moveable = false
				player.global_position = $Rope/Position2D.global_position
				player.global_rotation = $Rope/Position2D.global_rotation
		if Input.is_action_just_released("ui_accept"):
				$Rope.visible = false
				$AnimationPlayer.stop()
				player.moveable = true
				player.global_rotation = 0.0
				player.velocity.y -= 700
				already = false
			



func _on_Area2D_body_entered(body):
	if body.name == "Demon":
		useable = true


func _on_Area2D_body_exited(body):
	if body.name == "Demon":
		useable = false
