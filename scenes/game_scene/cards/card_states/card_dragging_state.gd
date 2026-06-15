extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.05

var minimum_drag_time_elapsed := false
var drag_offset: Vector2
var card_anchor: Vector2

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
	
	card_anchor = Vector2(card_ui.size.x / 2, card_ui.size.y / 4)
	setup_decaying_drag_offset()
	
	card_ui.color.color = Color.AQUAMARINE
	
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)


func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	if mouse_motion:
		var target = card_ui.get_global_mouse_position() - card_anchor
		card_ui.global_position = target + drag_offset


	if not card_ui.targets.is_empty():
		transition_requested.emit(self, CardState.State.HOVERING)
	elif cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif minimum_drag_time_elapsed and confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)


func setup_decaying_drag_offset() -> void:
	drag_offset = card_ui.global_position - (card_ui.get_global_mouse_position() - card_anchor)
	var tween = card_ui.create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "drag_offset", Vector2.ZERO, 0.15)
