extends AnimatedSprite

func _ready():
  play("standing")

func _process(delta):
  if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
    play("raising")
  else: play("standing")
