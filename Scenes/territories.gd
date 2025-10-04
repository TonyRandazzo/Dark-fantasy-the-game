extends Node2D

@export var position_variation: int = 3  
@export var auto_shuffle_on_ready: bool = true

func _ready():
	if auto_shuffle_on_ready:
		shuffle_children()

#funziona che rimescola e riposiziona i posti
func shuffle_children():
	hide_all_children()
	
	#rileva la presenza di nodi figli e li mette nell'array children
	var children = get_children()
	if children.is_empty():
		return
	
	var children_to_show = randi_range(1, children.size())
	
	#rimescola gli elementi dell'array per mettere tipo la caverna al posto della città
	children.shuffle()
	
	#itera per ogni figlio per quelli che deve far vedere e cambia un pochino la posizione per diversità
	for i in range(children_to_show):
		var child = children[i]
		if child is CanvasItem:  
			child.show()
			
			var original_position = child.position
			var random_offset_x = randf_range(-position_variation, position_variation)
			var random_offset_y = randf_range(-position_variation, position_variation)
			child.position = Vector2(
				original_position.x + random_offset_x,
				original_position.y + random_offset_y
			)

#funzione che nasconde i posti (nodi figli)
func hide_all_children():
	for child in get_children():
		if child is CanvasItem:
			child.hide()
