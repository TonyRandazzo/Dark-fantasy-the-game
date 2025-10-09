extends Node2D


func _on_pause_button_pressed() -> void:
	get_tree().paused = !get_tree().paused
	$PauseScreen.visible = !$PauseScreen.visible


func _on_continue_pressed() -> void:
	get_tree().paused = !get_tree().paused
	$PauseScreen.visible = !$PauseScreen.visible


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
