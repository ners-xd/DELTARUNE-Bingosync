/// PATCH .ignore if CHAPTER_1

/// REPLACE
if (instance_exists(obj_border_controller))
/// CODE
// Removes the condition entirely
if (true)
/// END

/// REPLACE
    else
/// CODE
    else if (variable_global_exists("num_goals"))
/// END