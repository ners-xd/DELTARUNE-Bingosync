/// IMPORT

if (prog < array_length(pages))
{
    texture_prefetch(pages[prog]);
    prog++;
}
else if (variable_global_exists("num_goals"))
{
    loaded = true;
    global.prefetchtexload = true;
}