package nice.cli;

/*
*   Helper class that helps maintain output styles
*/

class Output
{
    private static var prefix = "[Nice] ";
    private static var errorPrefix = "**";

    public static function text(msg : String)
    {
        Sys.println(prefix + msg);
    }

    public static function error(msg : String)
    {
        Sys.println(prefix + errorPrefix + " " + msg + " " + errorPrefix);
    }
}
