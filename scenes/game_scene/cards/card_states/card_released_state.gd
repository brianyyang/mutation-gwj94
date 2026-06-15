extends CardState

var on_board: bool
var cleanup_done: bool

func enter() -> void:
	card_ui.color.color = Color.DARK_MAGENTA
	on_board = false
	
	if not card_ui.targets.is_empty():
		on_board = true


func on_input(_event: InputEvent) -> void:
	if on_board:
		if !cleanup_done:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			cleanup_done = true
		return
	
	transition_requested.emit(self, CardState.State.BASE)
