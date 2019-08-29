package nice.cli.commands;

import nice.lib.Build;

class DefaultCommand extends Command
{
    private static var logo : String = "d8b   db d888888b  .o88b. d88888b\n888o  88   `88'   d8P  Y8 88'\n88V8o 88    88    8P      88ooooo\n88 V8o88    88    8b      88~~~~~\n88  V888   .88.   Y8b  d8 88.\nVP   V8P Y888888P  `Y88P' Y88888P";

    public function new()
    {
        super("default", "Default command");
    }

    public override function onExecute(args : Array<String>)
    {
        Sys.println(logo + '\n');

        Sys.println(" ~ A static site generator that is not mean. ~\n");
    }
}
