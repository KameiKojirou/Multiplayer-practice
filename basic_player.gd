extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D

func _enter_tree():
	set_multiplayer_authority(name.to_int())

func _ready():
	if is_multiplayer_authority():
		camera.make_current()

func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * 400
	move_and_slide()
