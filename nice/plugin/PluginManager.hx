package nice.plugin;

import hscript.Parser;

import nice.cli.Output;
import nice.lib.core.Post;

class PluginManager
{
    var _path : String;
    var _plugins : Array<Plugin>;

    public function new(path : String)
    {
        _path = path;
        _plugins = [];
    }

    /**
     * Add a plugin by name 
     * @param name 
     */
    public function add(name : String) : Void
    {
        _plugins.push(new Plugin(_path + "/" + name));
    }

    /**
     * Execute all loaded plugins
     * @param posts 
     * @param pages 
     */
    public function execute(posts : Array<Post>, pages : Array<Post>) : Void
    {
        var programs = [];
        var parser = new hscript.Parser();

        for(plugin in _plugins)
        {
            programs.push(parser.parseString(plugin.getSource()));
        }

        var interp = new hscript.Interp();

        interp.variables.set("posts", posts);
        interp.variables.set("pages", pages); 
        interp.variables.set("print", Output.plugin);

        for(program in programs)
        {
            Output.plugin(interp.execute(program));
        }
    }
}