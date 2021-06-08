extends KinematicBody2D

func _physics_process(delta):
	var deg : float = $spriteBOI.get_rotation_degrees()
	$spriteBOI.set_rotation_degrees(deg + 7)
