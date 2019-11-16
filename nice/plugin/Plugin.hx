package nice.plugin;

import sys.io.File;

class Plugin
{
    var _source : String;
    var _path : String;

    public function new(path : String)
    {
        _path = path;
        _source = File.getContent(path);
    }

    public function getSource()
    {
        return _source;
    }
}