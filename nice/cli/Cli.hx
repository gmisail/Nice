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

    public dynamic function onCreatePost(name : String)
    {

    }

    public dynamic function onCreatePage(name : String)
    {

    }

    public function process()
    {
        var command = args[0];
        var name : String = cast Date.now();

        if(args[1] != null) name = args[1];

        switch(command)
        {
            case "build":
                onBuild();
            case "create":
                onCreate();
            case "create-page":
                onCreatePage(name);
            case "create-post":
                onCreatePost(name);
            default:
                onDefault();
        }
    }
}