extends CanvasLayer


func _ready():
	Global.GUI = self


func update_GUI(lives, coins, animation):
	$Banner/HBoxContainer/LifeCount.text = str(lives)
	$Banner/HBoxContainer/CoinCount.text = str(coins)
	$AnimationPlayer.play(animation)