class_name Helper

static var count: int = 0
static var old_time: String = ""

static func generate_unique_id() -> String:
    var time = str(Time.get_time_dict_from_system())
    if time == old_time:
        count += 1
    else:
        count = 0
    old_time = time
    var uuid = str(count) + "_" + time
    return uuid

