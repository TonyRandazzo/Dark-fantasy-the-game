extends Control #può usare layout e nodi grafici
#segnale personalizzato, emesso quando cutscene termina, passando la “scelta” come stringa
signal cutscene_ended(result: String)

var lines: Array[String] = []
#chi parla
var speakers: Array[String] = []
#contiene le scelte
var choices: Array[String] = []
#indice della battuta
var current_line: int = 0
#scelta in schermo, c'è o non c'è
var choices_shown: bool = false


#SETUP DEI DATI
#quando istanzi la scena, riceve la cutscene con i suoi dati
func setup(c: CutsceneData) -> void:
	#copia nell'array  this, i dati dell'array istanziato ...
	lines = c.lines
	speakers = c.speakers
	choices = c.choices
	#l'indice della battuta quando la cutscene è nuova è 0
	current_line = 0
	#non ci sono scelte appena inizia, al massimo usciranno dopo
	choices_shown = false
	#fa subito visualizzare la prima linea
	_show_line()


#AVANZARE NEI DIALOGHI
# InputEvent è la classe base che rappresenta qualsiasi evento di input ricevuto
#quindi _INPUT eseguita ogni "event" di tipo InputEvent
func _input(event: InputEvent) -> void:
	#se hai premuto il tasto per avanzare nel dialogo, e non ci sono scelte
	if event.is_action_pressed("ui_accept") and not choices_shown:
		#allora mostra dialogo
		_show_line()



#MOSTRARE UNA LINEA
func _show_line() -> void:
	if current_line < lines.size():
		
		#la current_line viene scritta come:
		#vai nel nodo figlio chiamato DialogueBox, e dentro di lui prendi il nodo chiamato Text
		#poi accedi alle sue proprietà.text| insomma è come dare l'indirizzo del nodo della scena "dialogue"
		# "$DialogueBox/Text" è come fare "get_node("DialogueBox/Text")
		$DialogueBox/Text.text = lines[current_line]  
		#sceglie chi parla
		var speaker = speakers[current_line] if current_line < speakers.size() else ""
		#fa la stessa cosa di prima ma con il Nome di chi parla
		$DialogueBox/Name.text = speaker
		current_line += 1
		#se non ci sono piu battute passa alle scelte
	else:
		_show_choices()




func _show_choices() -> void:
	choices_shown = true
	var container := $DialogueBox/ChoicesContainer
	if container == null:
		push_error("ChoicesContainer non trovato sotto DialogueBox")
		return

	for child in container.get_children():
		child.queue_free()

	for choice in choices:
		var btn := Button.new()
		btn.text = choice
		btn.focus_mode = Control.FOCUS_NONE
		btn.pressed.connect(_on_choice_pressed.bind(choice))
		container.add_child(btn)



func _on_choice_pressed(choice: String) -> void:
	emit_signal("cutscene_ended", choice)
	queue_free()
