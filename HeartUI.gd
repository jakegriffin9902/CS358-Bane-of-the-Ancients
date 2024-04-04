extends TextureProgressBar

func _physics_process(_delta):
	updateHeart()

func updateHeart():
	value=PlayerScript.curHealth
	if (PlayerScript.curHealth>=10):
		get_node("HeartUIText").text=str(PlayerScript.curHealth)
	else :
		get_node("HeartUIText2").text=str(PlayerScript.curHealth)
