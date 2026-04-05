extends GridContainer
var items : Array
var item : Dictionary
var pos = 0

func _ready():
	items = get_children()
	
	for i in GlobalSignals.inventory:
		pos = 0
		item = Equipment.equipment_data[i]
		items[pos].title = item.title
		items[pos].panel_text = item.descript_text
		items[pos].full_style.texture = load(item.inv_fullimg)
		items[pos].icon = load(item.inv_icon)
		pos += 1
