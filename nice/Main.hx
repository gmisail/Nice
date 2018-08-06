package nice;

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

        }

        cli.process();
    }
}