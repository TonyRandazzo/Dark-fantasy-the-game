extends Node2D

# Scala modificabile dell'icona (può essere cambiata dall'Inspector)
@export var icon_scale: Vector2 = Vector2(0.5, 0.5)

# Riferimento allo sprite e dati associati
var sprite: Sprite2D = null
var data: Resource = null

func _ready() -> void:
	# Trova lo Sprite2D figlio e assicurati che sia visibile
	if has_node("Sprite2D"):
		sprite = $Sprite2D
		sprite.visible = true

# Assegna i dati e aggiorna la texture dello sprite
func setup(node_data: Resource) -> void:
	data = node_data
	if sprite != null and data != null and "icon" in data and data.icon != null:
		sprite.texture = data.icon  # applica l'icona
		sprite.position = Vector2.ZERO  # centra nello stesso nodo
		sprite.scale = icon_scale       # applica scala modificabile
