# res://data/DataManager.gd
extends Node
class_name DataManager

var node_data_list: Array = []

func _ready() -> void:
	_load_node_data("res://data/nodi")

func _load_node_data(path: String) -> void:
	var dir = DirAccess.open(path)
	if dir == null:
		push_error("Impossibile aprire directory: %s" % path)
		return

	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		# salta le directory
		if not dir.current_is_dir():
			if file_name.to_lower().ends_with(".tres"):
				var full = path + "/" + file_name
				var res = ResourceLoader.load(full)
				if res != null:
					node_data_list.append(res)
				else:
					push_warning("Impossibile caricare resource: %s" % full)
		file_name = dir.get_next()
	dir.list_dir_end()

	print("Loaded node_data_list:", node_data_list)
