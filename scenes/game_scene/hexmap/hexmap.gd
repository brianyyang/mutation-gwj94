extends TileMapLayer

@export var map_size: int

const OUTER_FILL: Dictionary = {
	"top":           Vector2i(1, 0),
	"top_right":     Vector2i(2, 0),
	"bot_right":     Vector2i(3, 0),
	"bot":           Vector2i(4, 0),
	"bot_left":      Vector2i(0, 1),
	"top_left":      Vector2i(1, 1),
	"top_and_right": Vector2i(2, 1),
	"top_and_left":  Vector2i(3, 1),
	"bot_and_right": Vector2i(4, 1),
	"bot_and_left":  Vector2i(0, 2),
}

func _ready() -> void:
	for y in map_size:
		for x in map_size:
			set_cell(Vector2i(x - map_size / 2, y - map_size / 2), 0, Vector2i(0, 0))
	if map_size % 2 == 0:
		setup_outline_hexes(1, 0)
	else:
		setup_outline_hexes(0, 1)


func setup_outline_hexes(even_offset: int, odd_offset: int) -> void:
	# setup top
	set_cell(Vector2i(-map_size / 2 - 1, -map_size / 2 - 1), 0, OUTER_FILL.get("bot"))
	
	# setup sides
	for hex in map_size - 1:
		# setup top left
		set_cell(Vector2i(-map_size / 2 - 1, -map_size / 2 + hex), 0, OUTER_FILL.get("bot_and_right"))
		# setup top right
		set_cell(Vector2i(-map_size / 2 + hex, -map_size / 2 - 1), 0, OUTER_FILL.get("bot_and_left"))
		# setup bot left
		set_cell(Vector2i(map_size / 2 - hex - even_offset, map_size / 2 + odd_offset), 0, OUTER_FILL.get("top_and_right"))
		# setup bot right
		set_cell(Vector2i(map_size / 2 + odd_offset, map_size / 2 - hex - even_offset), 0, OUTER_FILL.get("top_and_left"))
	set_cell(Vector2i(-map_size / 2 - 1, -map_size / 2 + map_size - 1), 0, OUTER_FILL.get("bot_right"))
	set_cell(Vector2i(-map_size / 2, -map_size / 2 + map_size), 0, OUTER_FILL.get("top_right"))
	set_cell(Vector2i(map_size / 2 - even_offset, -map_size / 2 - 1), 0, OUTER_FILL.get("bot_left"))
	set_cell(Vector2i(map_size / 2 + odd_offset, -map_size / 2), 0, OUTER_FILL.get("top_left"))

	# setup bot
	set_cell(Vector2i(map_size / 2 + odd_offset, map_size / 2 + odd_offset), 0, OUTER_FILL.get("top"))
