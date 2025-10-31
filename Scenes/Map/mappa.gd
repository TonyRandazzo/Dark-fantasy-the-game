extends Node2D


#QUESTO METODO CENTRA LA MAPPA NELLO SCHERMO
func _ready():
	var map_sprite = $Mappa  # Sprite2D figlio della mappa
	if map_sprite.texture:   # assicuriamoci che abbia una texture
		var screen_size = get_viewport_rect().size
		map_sprite.scale = Vector2(
			screen_size.x / map_sprite.texture.get_width(),
			screen_size.y / map_sprite.texture.get_height()
		)
		map_sprite.position = Vector2.ZERO  # in alto a sinistra




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
