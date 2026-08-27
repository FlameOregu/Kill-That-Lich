extends Label
var style_rank : String = "F"
var style_points : int = 0
var styling : bool
@export var style_time : ProgressBar
@export var style_timer : Timer
var rank_thresholds = {
	"F": 50,
	"E": 150,
	"D": 450,
	"C": 1350,
	"B": 4050,
	"A": 12150,
	"S": 36450
}
signal style #updates the attack node style for the damage mult
signal style_pts #style points label

func _on_attack(damage) -> void:
	styling = true
	style_points += damage + (GlobalSignals.flair * 15) #later, change it so global signals sets a battlestat and changes it according to thresholds e.g at 5 it's 20 per instead of 15
	if style_points >= rank_thresholds[style_rank]:
		for rank in rank_thresholds:
			if style_points >= rank_thresholds[rank]:
				style_rank = rank
			else:
				break
	style.emit(style_rank)
	style_pts.emit(style_points)
	style_timer.start()
	self.text = style_rank

func _process(delta: float) -> void:
	if styling == true:
		style_time.value = style_timer.time_left

func _on_style_timer_timeout() -> void:
	if style_rank == "F":
		style_points = 0
		styling = false
	else:
		style_points = rank_thresholds[style_rank]
		style_points = style_points / 3
		style_rank = rank_thresholds.find_key(style_points)
		style_timer.start()
	style_pts.emit(style_points)
	self.text = style_rank
