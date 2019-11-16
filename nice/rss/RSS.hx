package nice.rss;

import haxe.xml.Printer;

/**
 * Manage the creation of RSS files
 */
class RSS
{
    private var _document : Xml;
    private var _root : Xml;
    private var _channel : Xml;
    private var _version : String = "2.0";

    /**
     * Create a new RSS document
     */
    public function new()
    {
        _document = Xml.createDocument();

        _root = Xml.createElement("rss");
        _root.set("version", _version);
        _document.addChild(_root);

        _channel = Xml.createElement("channel");
        _root.addChild(_channel);
    }

    /**
     * Add item to the RSS XML
     * @param title 
     * @param link 
     * @param body 
     */
    public function add(titleVal : String, linkVal : String, body : String = "") : Void
    {
        var item = Xml.createElement("item");
    
        var title = Xml.createElement("title");
        title.addChild(Xml.createPCData(titleVal));

        var link = Xml.createElement("link");
        link.addChild(Xml.createPCData(linkVal));

        var desc = Xml.createElement("description");
        desc.addChild(Xml.createPCData(_getDescription(body)));
    
        item.addChild(title);
        item.addChild(link);
        item.addChild(desc);

        _channel.addChild(item);
    }

    /**
     * Export the RSS XML as a string
     * @return String
     */
    public function generate() : String
    {
        return Printer.print(_document, true);
    }

    /**
     * Generate a description based off of the post's content
     * @param body 
     * @param limit = 100 
     * @return String
     */
    private function _getDescription(body : String, ?limit = 100) : String
    {
        if(body.length > limit)
        {
            var trimmedData = body.substr(0, limit);
            trimmedData += "...";

            return trimmedData;
        }
        
        return body;
    }
}