package nice;

import nice.core.Directory;
import nice.cli.Cli;

class Main
{
    public static function main()
    {
        var cli = new Cli();
        cli.onBuild = function()
        {
            #if !dev
                var currentDir = Sys.args().pop();
                Sys.setCwd(currentDir); 
            #end

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