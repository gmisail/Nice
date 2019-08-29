package nice.cli.commands;

import sys.io.File;
import nice.lib.core.Directory;

class CreateCommand extends Command
{
    public function new()
    {
        super("create", "Creates a new project.");
    }

    public override function onExecute(args : Array<String>)
    {
        if(args.length <= 0)
        {
            File.saveContent("config.json", "{}");
            Directory.create("_assets");
            Directory.create("_pages");
            Directory.create("_posts");
            Directory.create("_layouts");
            Directory.create("_public");

            Create.layout("index");
            Create.page("index");
            Create.post("MyFirstPost");
        }
        else
        {
            var name : String = args[1];
            var type = args[0];

            if(name == null)
            {
                Output.error("You must give your " + type + " a name!");
            }

            if(type == "post") Create.post(name);
            else if(type == "page") Create.page(name);
            else if(type == "layout") Create.layout(name);
            else Output.error("Unrecognized type " + type);
        }
    }
}
