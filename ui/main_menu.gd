extends CanvasLayer

class_name MainMenu

signal start_game


# The Main menu should just forawrd it's signals
func _on_button_pressed():
	start_game.emit()
