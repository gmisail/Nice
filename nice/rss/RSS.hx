package nice.rss;

class RSS
{
    private var _root : Xml;
    private var _channel : Xml;
    private var _version : String = "2.0";

    public function new()
    {
        _root = Xml.createElement("rss");
        _root.set("version", _version);

        _channel = Xml.createElement("channel");
        _root.addChild(_channel);
    }

    public function add(title : String)
    {
        var item : String = "<item>";
        item += "<title>" + title + "</title>";
        item += "</item>";

        var element = Xml.parse(item);
        trace(haxe.xml.Printer.print(element, true));

        _channel.addChild(element);
    }

    public function generate() : String
    {
        return haxe.xml.Printer.print(_root, true);
    }
}