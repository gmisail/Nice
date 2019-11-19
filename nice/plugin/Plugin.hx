package nice.plugin;

import sys.io.File;

import nice.cli.Output;

class Plugin
{
    var _source : String;
    var _path : String;

    /**
     * Create a new plugin with the name 'path'
     * @param path 
     */
    public function new(path : String)
    {
        _path = path;
        _source = File.getContent(path);
    }

    /**
     *  Return the source of the plugin
     */
    public function getSource() : String
    {
        return _source;
    }

    public function getPath() : String
    {
        return _path;
    }
}