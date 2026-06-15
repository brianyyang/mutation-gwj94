extends CardState


func enter() -> void:
	card_ui.color.color = Color.GOLD
	card_ui.drop_point_detector.monitoring = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING)
