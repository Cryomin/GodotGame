extends Node2D

@export var bullet_scene: PackedScene
@export var muzzle_node_name: String = "Muzzle"
@export var shoot_cooldown: float = 0.5

signal shooting
var can_shoot: bool = true
var cooldown_timer: Timer = null

func _ready():
	cooldown_timer = Timer.new()
	cooldown_timer.one_shot = true
	add_child(cooldown_timer)
	cooldown_timer.timeout.connect(_reset_shoot_cooldown)

func shoot() -> void:
	if not can_shoot:
		return

	var muzzle = $Muzzle

	var bullet = bullet_scene.instantiate()
	if bullet:
		emit_signal("shooting")
		$AnimationPlayer.play("shoot_right")
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = muzzle.global_position
		bullet.rotation = muzzle.global_rotation
		$CPUParticles2D.emitting = true
	else:
		print("Failed to instantiate bullet!")
	can_shoot = false
	cooldown_timer.wait_time = shoot_cooldown
	cooldown_timer.start()

func _reset_shoot_cooldown() -> void:
	can_shoot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = get_global_mouse_position() - global_position
	rotation = direction.angle()
		
	if rotation < -1.5 or rotation > 1.5:
		scale.y = -1
		set_z_index(1)
		
	else:
		scale.y = 1
		set_z_index(-1)
	
	if Input.is_action_pressed("shoot"):
		shoot()
