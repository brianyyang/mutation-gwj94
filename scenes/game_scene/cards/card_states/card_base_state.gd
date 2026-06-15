extends CardState


func enter() -> void:
	if not card_ui.is_node_ready():
		await card_ui.ready

	card_ui.reparent_requested.emit(card_ui)
	card_ui.color.color = Color("#266116")
	card_ui.pivot_offset = Vector2.ZERO
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	card_ui.color.visible = true


func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.State.CLICKED)
