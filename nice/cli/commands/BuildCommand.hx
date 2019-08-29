package nice.cli.commands;

import nice.lib.Build;

class BuildCommand extends Command
{
    public function new()
    {
        super("build", "Builds the project.");
    }

    public override function onExecute(args : Array<String>)
    {
        Build.process();
        Build.compile();

        Output.text("Done.");
    }
}
