extends CardState

var on_board: bool

func enter() -> void:
	card_ui.color.color = Color.DARK_MAGENTA
	on_board = false
	
	if not card_ui.targets.is_empty():
		on_board = true


func on_input(_event: InputEvent) -> void:
	if on_board:
		return
	
	transition_requested.emit(self, CardState.State.BASE)
