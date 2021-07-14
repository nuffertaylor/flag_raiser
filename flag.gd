extends AnimatedSprite

var canRise = true
var atTop = false

func _ready():
  play("rising")


func _process(delta):
  if not atTop:
    if Input.is_action_pressed("ui_down"): 
      canRise = true
    elif Input.is_action_pressed("ui_up"):
      if canRise:
        canRise = false
        if !$ropeSfx.playing:
          $ropeSfx.play()
        set_position(get_position() - Vector2(0,15))
        if(get_position().y <= 185):
          atTop = true
          set_position(Vector2(get_position().x, 185))
          play("top")
          $ropeSfx.stop()
    
    
#    t += delta * 0.4
#
#    $Sprite.position = $A.position.linear_interpolate($B.position, t)
