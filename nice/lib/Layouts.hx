package nice.lib;

import nice.lib.core.Directory;
import nice.lib.core.Layout;

class Layouts
{
    private var directory : Directory;
    private var layouts : Map<String, Layout>;

    public function new()
    {
        directory = new Directory("_layouts");

        layouts = new Map();
        for(layout in directory.files())
        {
            layouts.set(layout, new Layout(layout, directory.getFile(layout)));
        }
    }

    public function getLayout(name : String)
    {
        return layouts.get(name);
    }
}