extends Node2D

signal cutscene_ended(result: String)

var lines: Array[String] = []
var speakers: Array[String] = []
var choices: Array[String] = []
var current_line: int = 0
var choices_shown: bool = false

# --- SETUP DEI DATI ---
func setup(c: CutsceneData) -> void:
	# copia dati ricevuti (stampo per debug)
	lines = c.lines
	speakers = c.speakers
	choices = c.choices
	current_line = 0
	choices_shown = false

	print("--- setup cutscene ---")
	print("cutscene resource:", c)
	print("lines.size():", lines.size(), "lines:", lines)
	print("speakers.size():", speakers.size(), "speakers:", speakers)
	print("choices.size():", choices.size(), "choices:", choices)

	# se non ci sono linee, esci (mostra debug)
	if lines.is_empty():
		push_warning("setup: lines è vuoto. Controlla il CutsceneData passato.")
		if not choices.is_empty():
			_show_choices()
		return


	# assicurati che i nodi figlio siano pronti: usa call_deferred per sicurezza
	call_deferred("_show_line")


# --- INPUT ---
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and not choices_shown:
		_show_line()


# --- MOSTRA LINEA ---
func _show_line() -> void:
	# controllo di sicurezza
	if $DialogueBox == null:
		push_error("DialogueBox non trovato.")
		return
	if $DialogueBox.has_node("Text") == false:
		push_error("DialogueBox/Text non trovato.")
		return

	print("current_line:", current_line, "lines.size():", lines.size())
	if current_line < lines.size():
		print("Mostro linea:", lines[current_line])
		$DialogueBox.get_node("Text").text = str(lines[current_line])

		var speaker := ""
		if current_line < speakers.size():
			speaker = speakers[current_line]
		$DialogueBox.get_node("Name").text = speaker

		current_line += 1
		print("Incremento current_line ->", current_line)

		# se dopo l'incremento siamo arrivati alla fine e ci sono scelte, le mostro
	if choices.is_empty():
		print("Nessuna scelta disponibile.")
		return
	else:
		print("Nessuna linea rimasta, passo alle scelte")
		_show_choices()


# --- MOSTRA SCELTE ---
func _show_choices() -> void:
	choices_shown = true
	var container := $DialogueBox.get_node("ChoicesContainer") if $DialogueBox.has_node("ChoicesContainer") else null
	if container == null:
		push_error("ChoicesContainer non trovato sotto DialogueBox")
		return

	for child in container.get_children():
		child.queue_free()

	if choices.is_empty():
		print("Nessuna scelta disponibile.")
		return

	for choice in choices:
		var btn := Button.new()
		btn.text = choice
		btn.focus_mode = Control.FOCUS_NONE
		btn.pressed.connect(_on_choice_pressed.bind(choice))
		container.add_child(btn)


func _on_choice_pressed(choice: String) -> void:
	emit_signal("cutscene_ended", choice)
	queue_free()
