package nice.cli;

/*
*   Helper class that helps maintain output styles
*/



class Output
{
    private static var prefix = "<red>[Nice]</> ";
    private static var errorPrefix = "**";
    private static var warningPrefix = "!!";

    public static function text(msg : String)
    {
        Console.printlnFormatted(prefix + msg);
    }

    public static function error(msg : String)
    {
        Console.printlnFormatted("<red>" + prefix + errorPrefix + " " + msg + " " + errorPrefix + "</>");
    }

    public static function warning(msg : String)
    {
        Console.printlnFormatted("<green>" + prefix + warningPrefix + " " + msg + " " + warningPrefix + "</>");
    }

    public static function plugin(msg : String)
    {
        Console.printlnFormatted("<blue>" + prefix + "(Plugin) " + msg + " " + "</>");
    }
}
