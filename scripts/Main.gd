extends Node

var canPull = true
var atTop = false
var counting = false

func startGame():
  $HUD.reset()
  $flag.play("rising")
  $flag.set_position(Vector2(300,500))
  $HUD.updateHighScore()
  $Score.start()
  $flapping.stop()
  $HUD.hideDirections()
  
func roundComplete():
  atTop = true
  $flag.set_position(Vector2($flag.get_position().x, 185))
  $flag.play("top")
  get_node("flag/ropeSfx").stop()
  get_node("flag/fanfare").play()
  $Score.stop()
  $HUD.submitScore()
  $flapping.play()
  $HUD.setDirections("press up/down to try again")
  $cooldown.start()

func _ready():
  $HUD.updateHighScore()
  $HUD.setDirections("press up/down to start")

func _input(event):
  if event.is_pressed() and not counting:
    counting = true
    startGame()

func _process(delta):
  if not atTop:
    if Input.is_action_pressed("ui_up"):
      if canPull:
        $HUD.flip(false)
        canPull = false
    elif Input.is_action_pressed("ui_down"):
      if not canPull:
        $HUD.flip(true)
        canPull = true
        if not get_node("flag/ropeSfx").playing:
          get_node("flag/ropeSfx").play()
        $flag.set_position($flag.get_position() - Vector2(0,15)) #possibly set this using liner_interpolation so it doesn't jump
        if($flag.get_position().y <= 185):
          roundComplete()
          
func _on_Score_timeout():
  $HUD.updateScore()

func _on_cooldown_timeout():
  counting = false
  atTop = false
  canPull = true
