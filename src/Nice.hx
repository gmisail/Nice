package;

class Nice
{
    public static function main()
    {
        var command = Sys.args()[0];
        
        switch(command){
            case "new":
                Sys.println("Nice -> Creating new project");
                Config.createProject();

            case "help":
                Sys.println("Nice -> Help");
                Sys.println("========================================");
                Sys.println("=  new [name] -> Create a new project  =");
                Sys.println("=  build -> Build the current project  =");
                Sys.println("=  help -> Get help for Nice           =");
                Sys.println("========================================");
                
            case "build":
                Sys.println("Nice -> Reading files");
        
                Config.load(function(){
                    Generator.init();
                });
        }
    }
}