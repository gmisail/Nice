package nice.cli.commands;

import nice.Create;
import nice.cli.Command;
import nice.cli.Output;

class CreateCommand extends Command
{
    public function new()
    {
        super("create", "Creates a new project.");
    }

    public override function onExecute(args : Array<String>)
    {
        var name : String = args[1];
        var type = args[0];

        if(type == null)
        {
            Output.error("Create command cannot be empty!");
            Sys.exit(1);
        }

        if(name == null)
        {
            Output.error("You must give your " + type + " a name!");
            Sys.exit(1);
        }
    
        if(type == "post") Create.post(name);
        else if(type == "page") Create.page(name);
        else if(type == "layout") Create.layout(name);
        else if(type == "project") Create.project();
    
        else Output.error("Unrecognized type " + type);
    
    }
}
