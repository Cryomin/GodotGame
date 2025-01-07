extends Area2D

@export var speed: float = 500.0
@export var lifespan: float = 3.0

signal my_signal

func _ready():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = lifespan
	add_child(timer)
	timer.start()
	timer.timeout.connect(self.queue_free)

func _process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body as Enemy
		body.enemdmg(1)
	queue_free()
