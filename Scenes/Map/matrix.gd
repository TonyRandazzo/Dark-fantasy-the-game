extends Node2D

# Preload della scena del nodo e dello script dei dati
const MapNodeScene = preload("res://Scenes/MapNodes/MapNode.tscn")
const NodeData = preload("res://data/NodeData.gd")  # script dei dati (tipo, icona, ecc.)

# Array dei tipi di nodo disponibili (città, foresta, caverna, ecc.)
@export var node_data_types: Array[NodeData] = []  

# Dimensioni della griglia
@export var columns: int = 15
@export var rows: int = 10
@export var spawn_chance: int = 70  # % probabilità di generare un nodo in una cella

# Memoria della matrice e dimensioni delle celle
var matrix = []
var cell_width = 0
var cell_height = 0

func _ready() -> void:
	update_grid_size()
	generate_matrix()

# Calcola le dimensioni delle celle in base alla finestra
func update_grid_size() -> void:
	var viewport_size = get_viewport_rect().size
	cell_width = viewport_size.x / columns
	cell_height = viewport_size.y / rows

# Genera la matrice con nodi
func generate_matrix() -> void:
	matrix.clear()
	for r in range(rows):
		var row_data = []
		for c in range(columns):
			# Verifica probabilità e che ci siano dati da assegnare
			if randi() % 100 < spawn_chance and node_data_types.size() > 0:
				var node_instance = MapNodeScene.instantiate()
				add_child(node_instance)  # aggiunge alla scena, così _ready() di MapNode viene chiamato
				node_instance.position = Vector2(
					c * cell_width + cell_width/2,
					r * cell_height + cell_height/2
				)
				# Assegna un NodeData casuale
				var random_data = node_data_types.pick_random()
				node_instance.setup(random_data)
				row_data.append(node_instance)
			else:
				row_data.append(null)  # cella vuota
		matrix.append(row_data)
