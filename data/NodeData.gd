extends Resource
class_name NodeData
#NodeData estende Resource, non è un nodo della scena (Node2D, Control, ecc.), ma tiene solo dati
#quindi non entra mai nell’albero della scena. 
#quindi non servono _ready() e _process() 

@export var cutscenes_possibili: Array[CutsceneData] = []

@export var tipo: String # "foresta", "citta", "caverna"
@export var sprite: Texture2D
@export var nemici: Array[String] = []
@export var risorse: Array[String] = []
