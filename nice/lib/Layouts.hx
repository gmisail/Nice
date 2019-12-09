package nice.lib;

import nice.filesystem.Directory;
import nice.lib.core.Layout;

class Layouts
{
    private var _directory : Directory;
    private var _layouts : Map<String, Layout>;

    /*
        Open the layouts folder and load all of the file contents
    * */
    public function new(path : String)
    {        
        _directory = new Directory(path);

        _layouts = new Map();
        for(layout in _directory.files())
        {
            _layouts.set(layout, new Layout(layout, _directory.getFile(layout)));
        }
    }

    /*
        Get a layout by name
    * */
    public function getLayout(name : String)
    {
        return _layouts.get(name);
    }
}