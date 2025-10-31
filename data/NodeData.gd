extends Resource
class_name NodeData
#NodeData estende Resource, non è un nodo della scena (Node2D, Control, ecc.), ma tiene solo dati
#quindi non entra mai nell’albero della scena. 
#quindi non servono _ready() e _process() 

@export var tipo: String = ""  # "citta", "foresta", "caverna"
@export var cutscenes_possibili: Array[CutsceneData] = []
@export var icon: Texture2D  # proprietà per la texture
