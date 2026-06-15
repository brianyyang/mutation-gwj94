extends CardState

var card_anchor: Vector2
var hexmap: TileMapLayer

var card_target: Vector2
var hovering_hex: bool

func enter() -> void:
	hexmap = get_tree().get_first_node_in_group("hexmap_layer").tilemap
	card_anchor = Vector2(card_ui.size.x / 2, card_ui.size.y / 4)
	card_ui.color.visible = false
	hovering_hex = false


func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	if mouse_motion:
		snap_to_hexes()
		card_ui.global_position = card_target - card_anchor

	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif confirm:
		get_viewport().set_input_as_handled()
		if hovering_hex:
			transition_requested.emit(self, CardState.State.RELEASED)
		else:
			transition_requested.emit(self, CardState.State.BASE)


func snap_to_hexes() -> void:
	# convert mouse to local tilemap space, then to cell coordinates
	var mouse_pos = hexmap.get_global_mouse_position()
	var local_pos = hexmap.to_local(mouse_pos)
	var cell_coord = hexmap.local_to_map(local_pos)
	
	var cell_data = hexmap.get_cell_tile_data(cell_coord)
	if cell_data != null and cell_data.get_custom_data("placeable"):
		var cell_world = hexmap.to_global(hexmap.map_to_local(cell_coord))
		card_target = cell_world
		hovering_hex = true
	else:
		card_target = card_ui.get_global_mouse_position()
		hovering_hex = false
