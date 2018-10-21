package nice.cli;

class Cli
{
    private var args : Array<String>;

    public function new()
    {
        args = Sys.args();
    }

    public dynamic function onBuild()
    {

    }

    public dynamic function onCreate()
    {

    }

    public dynamic function onDefault()
    {

    }

    public function process()
    {
        var command = args[0];
        switch(command)
        {
            case "build":
                onBuild();
            case "create":
                onCreate();
            default:
                onDefault();
        }
    }
}