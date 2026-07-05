/// PATCH

/// REPLACE
                global.gold -= cost;
                msgset(0, scr_itemget_anytype_text(itemid, "item"));
/// CODE
                msgset(0, scr_itemget_anytype_text(itemid, "item"));
                global.gold -= cost;
/// END