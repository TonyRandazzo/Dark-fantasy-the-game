extends Resource
class_name CutsceneData

@export var id: String
@export var tipo: String # "dialogo", "fight", ecc.
@export var scena: PackedScene
@export var lines: Array[String] = []
@export var choices: Array[String] = []
@export var narration: String = ""
@export var actions: Array[String] = []
