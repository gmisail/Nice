package nice;

import nice.fs.Directory;
import nice.cli.commands.*;
import nice.cli.Controller;
import nice.lib.Build;

import sys.io.File;

class Main
{
    public static function main()
    {
        /* initialize the command controller */
        var controller = new Controller();
        controller.addDefault(new DefaultCommand());
        controller.add(new BuildCommand());
        controller.add(new CreateCommand());
        controller.add(new DeleteCommand());

        /* Set the current working directory in the production version */
        #if !dev
            var currentDir = Sys.args().pop();
            Sys.setCwd(currentDir);
        #end

        controller.run();
    }
}