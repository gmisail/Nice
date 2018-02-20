package;

class Nice
{
    public static function main()
    {
        Sys.println("Nice -> Reading files");
        
        Config.load(function(){
            Generator.init();
        });
    }
}