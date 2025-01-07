extends CharacterBody2D

var dashvel
var run_speed = 80.0
var max_health = 10
@onready var health = max_health
var dir = "left"
var input_direction
var look_direction
var look_direction_deg
signal healthsig(health)
@export var speed = 300
var dashing = false
func get_input():
	input_direction = Input.get_vector("left","right","up","down")
	
func dash():
	if dashing == false:
		velocity = 2000 * input_direction
		print(input_direction)
		input_direction = Input.get_vector("left","right","up","down")
		dashing = true
	
	
func _physics_process(delta):
	if Input.is_action_just_pressed("dash"):
		dash()
	if dashing == true:
		if velocity.length() <= 300:
			dashing = false
		move_and_slide()
		velocity -= 100 * input_direction
		print(velocity.length())
		print(input_direction)
	else:
		get_input()
		velocity = input_direction * speed
		move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		take_dmg(2)
		
		
	look_direction = get_global_mouse_position() - global_position
	look_direction_deg = rad_to_deg(look_direction.angle())
	if look_direction_deg < 90 and look_direction_deg > -90:
		dir = "right"
	elif look_direction_deg < -90 or look_direction_deg > 90:
		dir = "left"
	if velocity.x == 0 and velocity.y == 0:
		if dir == "right":
			dir = "idle_right"
		elif dir == "left":
			dir = "idle_left"
	$AnimationPlayer2.play(dir)
	$ShakeCamera/Label.text = "HP:" + str(health)
	
func take_dmg(dmg):
	if !$InvincFrames.paused:
		return
	elif $InvincFrames.paused:
		health -= dmg

		$InvincFrames.start()
	
	
	
