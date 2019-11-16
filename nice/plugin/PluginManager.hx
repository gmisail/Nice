package nice.plugin;

import hscript.Parser;

import nice.cli.Output;

class PluginManager
{
    var _path : String;
    var _plugins : Array<Plugin>;

    public function new(path : String)
    {
        _path = path;
        _plugins = [];
    }

    public function add(name : String) : Void
    {
        _plugins.push(new Plugin(_path + "/" + name));
    }

    public function execute() : Void
    {
        var programs = [];
        var parser = new hscript.Parser();

        for(plugin in _plugins)
        {
            programs.push(parser.parseString(plugin.getSource()));
        }

        var interp = new hscript.Interp();

        /**
         * TODO: Export all of the website related variables
         */
        interp.variables.set("Math",Math);
        interp.variables.set("angles",[0,1,2,3]); 

        for(program in programs)
        {
            Output.plugin(interp.execute(program));
        }
    }
}