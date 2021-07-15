extends Node

# true if up, false if down
export var up = true
export var highScore = 10
var UPDATE_SCORE_INCREMENT
var curScore = 0

# Called when the node enters the scene tree for the first time.
func _ready():
  flip(false)
  $score.text = str(curScore)
  
func reset():
  up = true
  curScore = 0

func flip(val):
  up = val
  if up:
    $downArrow.set_self_modulate(Color(.5,.5,.5,1))
    $upArrow.set_self_modulate(Color(1,1,1,1))
  else:
    $upArrow.set_self_modulate(Color(.5,.5,.5,1))
    $downArrow.set_self_modulate(Color(1,1,1,1))
    
func setDirections(msg):
  $direction.show()
  $direction.text = msg
  
func hideDirections():
  $direction.hide()
    
func updateScore():
  curScore += .01
  $score.text = str("%.2f" % curScore)
  
func updateHighScore():
  $highScore.text = "hi: " + str("%.2f" % highScore)
  
func submitScore():
  if(curScore < highScore):
    highScore = curScore
  updateHighScore()
