extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
  play("standing")


func _process(delta):
  if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
    play("raising")
  else: play("standing")
