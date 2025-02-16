extends Timer

var min = 1
var max = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randtime()
	$".".connect("timeout", Callable(self, "randtime"))

#func _start():
	#randtime()
	##_start()
	#
func randtime():
	set_wait_time(randi_range(min, max))
