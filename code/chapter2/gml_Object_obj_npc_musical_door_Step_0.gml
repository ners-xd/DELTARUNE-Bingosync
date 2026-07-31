/// PATCH
// This looks silly, but I have to do it like this because
// Switch is one version behind, and it doesn't have the patched Bagel Overflow
// so I have to write these instructions in a way that accommodates both scripts

/// AFTER
    with (nise_kknpc)
        scr_depth();
/// CODE
    if (false)
/// END

/// BEFORE
    fadeout = instance_create(0, 0, obj_fadeout);
/// CODE
    instance_deactivate_object(kknpc);
/// END

/// AFTER
    with (nise_kknpc)
        instance_destroy();
/// CODE
    instance_activate_object(kknpc);

    if (false)
/// END