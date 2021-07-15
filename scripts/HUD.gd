extends Node

# true if up, false if down
export var up = true
export var highScore = 10
var UPDATE_SCORE_INCREMENT
var curScore = 0
var SAVE_FILE_DIR = "user://flag_raiser.json"

# Called when the node enters the scene tree for the first time.
func _ready():
  flip(false)
  $score.text = str(curScore)
  loadGame()
  
func reset():
  up = true
  curScore = 0
  
func saveGame():
  var data = {"bestTime" : curScore}
  var file = File.new()
  file.open(SAVE_FILE_DIR, File.WRITE)
  print("opened file")
  print("writing " + to_json(data))
  file.store_line(to_json(data))
  file.close()
  
func loadGame():
  var file = File.new()
  if not file.file_exists(SAVE_FILE_DIR): 
    print("no file found")
    return
  file.open(SAVE_FILE_DIR, File.READ)
  var data = parse_json(file.get_line())
  highScore = data["bestTime"]
  updateHighScore()

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
    saveGame()
  updateHighScore()
