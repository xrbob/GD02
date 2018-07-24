extends Node2D

export var starting_lives = 3
export var coin_target    = 10

var lives
var coins


func _ready():
	
	Global.GameState = self
	lives = starting_lives
	coins = 0
	
	update_GUI("Hurt")


func update_GUI(animation):
	Global.GUI.update_GUI(lives, coins, animation)


func hurt():
	lives -= 1
	update_GUI("Hurt")
	
	Global.PainSFX.play()
	
	if lives < 0:
		end_game()
	else:
		Global.Player.take_damage()


func coin_up():

	if coins % coin_target == 0 and coins > 1:
		life_up()
		update_GUI("LifePulse")
	
	coins += 1
	
	update_GUI("CoinPulse")


func life_up():
	lives += 1


func end_game():
	Global.Player.play_dead()
	$DeathTimer.start()
	

func _on_DeathTimer_timeout():
	get_tree().change_scene(Global.GameOver)
