extends Node2D

@export_enum("caverna", "città", "foresta")
var bioma: String = "caverna"

var dialoghi := {
	"caverna": [
		[
			"È così buio qui dentro...",
			"Sento delle gocce cadere in lontananza.",
			"Non mi piace questo posto."
		],
		[
			"La caverna sembra non finire mai.",
			"Dovrei stare attento ai rumori.",
			"Spero di trovare un'uscita..."
		]
	],

	"città": [
		[
			"La città è sempre così rumorosa.",
			"La gente corre ovunque.",
			"Forse dovrei trovare un posto tranquillo."
		],
		[
			"I mercanti gridano le loro offerte.",
			"Sembra non esserci un attimo di pace.",
			"Mi chiedo come facciano a vivere così."
		]
	],

	"foresta": [
		[
			"Gli alberi sembrano osservare ogni mio passo.",
			"La luce filtra appena tra le foglie.",
			"Questo posto è misterioso..."
		],
		[
			"La foresta è piena di vita.",
			"Sento animali muoversi tra i cespugli.",
			"Devo procedere con cautela."
		]
	]
}

var ramo_corrente: Array = []
var indice_linea: int = 0


func _ready():
	inizializza_dialogo()

	# Connette il pulsante Continue
	$DialogueBox/Continue.pressed.connect(avanza_dialogo)

	# Connette il pulsante History
	$DialogueBox/History.pressed.connect(mostra_history)


func inizializza_dialogo():
	if not dialoghi.has(bioma):
		push_warning("Bioma non valido: %s" % bioma)
		return

	ramo_corrente = dialoghi[bioma].pick_random()
	indice_linea = 0

	mostra_linea()


func mostra_linea():
	var label := $DialogueBox/Text

	if label and indice_linea < ramo_corrente.size():
		label.text = ramo_corrente[indice_linea]


func avanza_dialogo():
	indice_linea += 1

	if indice_linea < ramo_corrente.size():
		mostra_linea()
	else:
		$DialogueBox/Text.text = "[FINE DIALOGO]"


# ----------------------------------------------------------
#                SISTEMA DI HISTORY DEL DIALOGO
# ----------------------------------------------------------

func mostra_history():
	# Rende visibile la finestra della storia
	$History.visible = not $History.visible

	var container := $History/ScrollContainer/VBoxContainer

	# Pulisce elementi precedenti
	for child in container.get_children():
		child.queue_free()

	# Nome del parlante
	var speaker_name = $DialogueBox/Name.text

	# Crea un blocco per ogni dialogo già mostrato
	for i in range(indice_linea):
		var linea = ramo_corrente[i]

		var margin := MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 10)
		margin.add_theme_constant_override("margin_right", 10)
		margin.add_theme_constant_override("margin_top", 5)
		margin.add_theme_constant_override("margin_bottom", 5)

		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.add_theme_constant_override("separation", 5)

		var label_name := Label.new()
		label_name.text = speaker_name
		label_name.add_theme_color_override("font_color", Color.LIGHT_GRAY)

		var label_dialogo := Label.new()
		label_dialogo.autowrap_mode = TextServer.AUTOWRAP_WORD
		label_dialogo.text = linea

		vbox.add_child(label_name)
		vbox.add_child(label_dialogo)
		margin.add_child(vbox)

		container.add_child(margin)
