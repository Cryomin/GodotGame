class_name Enemy extends CharacterBody2D

@export var player: CharacterBody2D
var dead = false
var enim_max_health = 5.0
var enim_health = enim_max_health
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if dead == true:
		if $DeathTimer.is_stopped():
			queue_free()
	position.x = player.position.x
	
func enemdmg(dmg):
	if enim_health > 0:
		enim_health -= dmg
		$Health.scale.x = enim_health / enim_max_health

	if enim_health <= 0:
		$AnimationPlayer.play("death")
		$DeathTimer.start()
		dead = true
