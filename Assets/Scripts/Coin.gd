extends AnimatedSprite


func _ready():
	pass


func _on_Area2D_body_entered(body):
	Global.GameState.coin_up()
	$Area2D/CollisionShape2D.disabled = true
	$AnimationPlayer.play("die")
	$AudioStreamPlayer.play()


func die():
	queue_free()

