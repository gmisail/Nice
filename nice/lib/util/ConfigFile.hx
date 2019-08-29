package nice.lib.util;

import haxe.Json;
import sys.io.File;

class ConfigFile
{
    private var path : String;
    private var rawContent : String;
    private var json : Json;

    public function new(path : String)
    {
        this.path = path;
        this.rawContent = File.getContent(path);
        this.json = Json.parse(this.rawContent);
    }

    public function getData() : Json
    {
        return json;
    }
}