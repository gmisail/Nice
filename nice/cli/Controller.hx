package nice.cli;

class Controller
{
    private var defaultCommand : Command;

    private var commands : Map<String, Command>;

    private var args : Array<String>;

    public function new()
    {
        commands = new Map<String, Command>();

        args = Sys.args();
    }

    public function run()
    {
        if(args.length > 0)
        {
            var command = args[0];
            var arguments = args.slice(1, args.length);

            if(commands.exists(command))
            {
                var currentCommand : Command = commands.get(command);
                currentCommand.onExecute(arguments);
            }
            else
                Output.error("Could not find command " + command);
        }
        else
        {
            if(defaultCommand != null) defaultCommand.onExecute([]);
            else Output.error("Cannot find default command.");
        }
    }

    public function help() : String
    {
        var output = "";

        for(command in commands)
        {
            output += command.name + " -> " + command.description + "\n";
        }

        return output;
    }

    public function add(command : Command)
    {
        commands.set(command.name, command);
    }

    public function addDefault(command : Command)
    {
        this.defaultCommand = command;
    }
}
