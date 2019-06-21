package nice;

import nice.core.Directory;
import nice.cli.Cli;
import nice.cli.Create;

import sys.io.File;

class Main
{
    private static var logo : String = "d8b   db d888888b  .o88b. d88888b\n888o  88   `88'   d8P  Y8 88'\n88V8o 88    88    8P      88ooooo\n88 V8o88    88    8b      88~~~~~\n88  V888   .88.   Y8b  d8 88.\nVP   V8P Y888888P  `Y88P' Y88888P";

    public static function main()
    {
        #if !dev
            var currentDir = Sys.args().pop();
            Sys.setCwd(currentDir);
        #end

        var cli = new Cli();

        cli.onDefault = function()
        {
            Sys.println(logo + '\n');

            Sys.println(" ~ A static site generator that is not mean. ~\n");

            Sys.println("create -> Generate a new project in the current directory.");
            Sys.println("create-post -> Create a blank post.");
            Sys.println("create-page -> Create a blank page.");
            Sys.println("build -> Build the project in the current directory.");
        }

        cli.onBuild = function()
        {
            Build.process();
            Build.compile();
        }

        cli.onCreate = function()
        {
            File.saveContent("globals.json", "{}");
            Directory.create("_assets");
            Directory.create("_pages");
            Directory.create("_posts");
            Directory.create("_layouts");
            Directory.create("_public");
        }

        cli.onCreatePage = function(name : String)
        {
            Create.page(name);
        }

        cli.onCreatePost = function(name : String)
        {
            Create.post(name);
        }

        cli.process();
    }
}