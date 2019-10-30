package nice.cli;

/*
*   Helper class that helps maintain output styles
*/



class Output
{
    private static var prefix = "[Nice] ";
    private static var errorPrefix = "**";
    private static var warningPrefix = "!!";

    public static function text(msg : String)
    {
        Console.println(prefix + msg);
    }

    public static function error(msg : String)
    {
        Console.printlnFormatted("<red>" + prefix + errorPrefix + " " + msg + " " + errorPrefix + "</>");
    }

    public static function warning(msg : String)
    {
        Console.printlnFormatted("<green>" + prefix + warningPrefix + " " + msg + " " + warningPrefix + "</>");
    }
}
