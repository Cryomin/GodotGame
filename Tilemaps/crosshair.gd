extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var mousex
var mousey
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mousex = get_global_mouse_position().x
	mousey = get_global_mouse_position().y
	self.set_global_position(Vector2(mousex, mousey))
