extends TextureProgressBar

func _physics_process(_delta):
	updateHeart()

func updateHeart():
	value=get_node("../..").curHealth
	if (get_node("../..").curHealth>=10):
		get_node("HeartUIText").text=str(get_node("../..").curHealth)
	else :
		get_node("HeartUIText2").text=str(get_node("../..").curHealth)
