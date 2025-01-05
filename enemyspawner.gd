extends Node2D

@export var enemy_scene: PackedScene
@export var pos: Vector2 
@export var list : Array[Vector2]
@export var player: CharacterBody2D

func _ready() -> void:
	pass
# Called when the node enters the scene tree for the first time.
func spawn() -> void:
	if enemy_scene:  # Ensure enemy_scene is assigned.
		for i in range (list.size()):
			var enemy = enemy_scene.instantiate() as Enemy
			if enemy:
				enemy.player = self.player
			
			add_child(enemy)  # Add the enemy to this node.
			enemy.global_position = list[i] # Adjust the position.
	else:
		print("Error: enemy_scene is not assigned!")
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		spawn()
	
