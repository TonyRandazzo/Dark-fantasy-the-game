extends Node2D


var matrix = []
@export var columns = 15
@export var rows = 10

var place = []
var cell_width = 0
var cell_height = 0

func _ready() -> void:
	place = get_children()
	update_grid_size()
	generate_matrix()
	_draw()


func _process(delta: float) -> void:
	pass

func generate_matrix():
	matrix.clear()
	for r in range(rows):
		var row_data = []
		for c in range(columns):
			row_data.append(place.pick_random())
		matrix.append(row_data)
		print(matrix)

func update_grid_size():
	var viewport_size = get_viewport_rect().size
	cell_width = viewport_size.x/columns
	cell_height = viewport_size.y/rows


func _draw() -> void:
	for i in range(columns + 1):
		var x = i * cell_width
		draw_line(Vector2(x, 0), Vector2(x, cell_height * rows), Color(1, 1, 1, 1), 1)

	for j in range(rows + 1):
		var y = j * cell_height
		draw_line(Vector2(0, y), Vector2(cell_width * columns, y), Color(1, 1, 1, 1), 1)
