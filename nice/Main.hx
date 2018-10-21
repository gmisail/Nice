package nice;

import nice.core.Directory;
import nice.cli.Cli;

class Main
{
    public static function main()
    {
        #if !dev
            var currentDir = Sys.args().pop();
            Sys.setCwd(currentDir);
        #end

        var cli = new Cli();

        cli.onDefault = function()
        {
            Sys.println("
d8b   db d888888b  .o88b. d88888b
888o  88   `88'   d8P  Y8 88'
88V8o 88    88    8P      88ooooo
88 V8o88    88    8b      88~~~~~
88  V888   .88.   Y8b  d8 88.
VP   V8P Y888888P  `Y88P' Y88888P
  ");
            Sys.println(" ~ A static site generator that is not mean. ~\n");

            Sys.println("create -> Generate a new project in the current directory.");
            Sys.println("build -> Build the project in the current directory.");
        }

        cli.onBuild = function()
        {
            Build.process();
            Build.compile();
        }

        cli.onCreate = function()
        {
            Directory.create("_assets");
            Directory.create("_pages");
            Directory.create("_posts");
            Directory.create("_layouts");
            Directory.create("_public");
        }

        cli.process();
    }
}