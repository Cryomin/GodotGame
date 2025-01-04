extends Area2D

@export var player: CharacterBody2D 

var dead = false
var enim_max_health = 5.0
var enim_health = enim_max_health
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if dead == true:
		if $DeathTimer.is_stopped():
			queue_free()
	print(player)
	position.x = player.position.x
	
func _on_area_entered(area: Area2D) -> void:
	if enim_health > 0:
		enim_health -= 1
		$Health.scale.x = enim_health / enim_max_health

	if enim_health <= 0:
		$AnimationPlayer.play("death")
		$DeathTimer.start()
		dead = true
