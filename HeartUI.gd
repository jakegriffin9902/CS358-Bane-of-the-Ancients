extends TextureProgressBar

func _physics_process(_delta):
	updateHeart()

func updateHeart():
	# This isn't great code, but works for now. It keeps the heart artwork full.
	value = PlayerStats.maxHealth
	if (PlayerStats.curHealth >= 10):
		get_node("HeartUIText").text=str(PlayerStats.curHealth)
		get_node("HeartUIText2").text=""
	else :
		get_node("HeartUIText2").text=str(PlayerStats.curHealth)
		get_node("HeartUIText").text=""
