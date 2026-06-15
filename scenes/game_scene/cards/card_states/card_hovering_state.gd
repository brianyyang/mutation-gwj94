extends CardState

var card_anchor: Vector2

func enter() -> void:
	card_anchor = Vector2(card_ui.size.x / 2, card_ui.size.y / 4)
	card_ui.color.visible = false


func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	if mouse_motion:
		var target = card_ui.get_global_mouse_position() - card_anchor
		card_ui.global_position = target

	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
