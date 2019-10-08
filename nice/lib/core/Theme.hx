package lib.core;

import nice.lib.core.Directory;

/**
 * Manages the loading / processing of themes
 */
class Theme
{
    private var name : String;
    private var directory : Directory;

    public function new(name : String, path : String)
    {
        this.name = name;
        this.directory = new Directory(path);
    }

    public function getName()
    {
        return name;
    }
}