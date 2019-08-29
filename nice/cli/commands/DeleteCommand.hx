package nice.cli.commands;

import sys.FileSystem;

class DeleteCommand extends Command
{
    public function new()
    {
        super("delete", "Deletes a file.");
    }

    public override function onExecute(args : Array<String>)
    {
        if(args.length > 0)
        {
            var type = args[0];
            var name = args[1];

            var prefix = "";
            if(type == "post") prefix = "_posts/";
            else if(type == "page") prefix = "_pages/";
            else if(type == "layout") prefix = "_layouts/";
            else
            {
                Output.error("Cannot find " + type + " " + name);
                return;
            }

            if(name == null)
            {
                Output.error("You must include the name of the " + type + " to delete!");
                return;
            }

            var path : String = prefix + name + ".html";

            if(FileSystem.exists(path))
            {
                FileSystem.deleteFile(path);
            }
            else
            {
                Output.error("Cannot find " + type + " with the name " + name);
                return;
            }
        }
    }
}
