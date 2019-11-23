package nice.plugin;

import hscript.Parser;
import hscript.Interp;

import nice.cli.Output;
import nice.lib.core.Post;

class PluginManager
{
    var _path : String;
    var _plugins : Array<Plugin>;

    var _interp : Interp;

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
        var parser = new hscript.Parser();
        
        _interp = new hscript.Interp();

        _interp.variables.set("posts", posts);
        _interp.variables.set("pages", pages); 
        _interp.variables.set("print", Output.plugin);

        for(plugin in _plugins)
        {
            Output.plugin("Executing Plugin: " + plugin.getPath());
            
            var output = _interp.execute(parser.parseString(plugin.getSource()));

            if(output != null)
                Output.plugin(output);
        }
    }
}