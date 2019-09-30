package nice.lib.util;

import haxe.Json;
import sys.io.File;

typedef ConfigData = {
    var assetsPath : String;
    var postsPath : String;
    var pagesPath : String;
    var layoutsPath : String;
    var outputPath : String;
    var variables: {};
}

/*
    Manages the config.json file and helps load properties
*/
class ConfigFile
{
    private var path : String;
    private var content : String;
    private var json : ConfigData;

    public function new(path : String)
    {
        this.path = path;
        this.content = File.getContent(path);
        this.json = Json.parse(this.content);
    }

    public function getVariables() : Dynamic
    {
        if (json.variables == null) return {};
        else return json.variables;
    }

    public function getOutputPath() : String
    {
        if(json.outputPath == null) return "_public";
        return json.outputPath;
    }

    public function getPostsPath(): String
    {
        if(json.postsPath == null) return "_posts";
        return json.postsPath;
    }

    public function getPagesPath(): String
    {
        if(json.pagesPath == null) return "_pages";
        return json.pagesPath;
    }

    public function getLayoutsPath(): String
    {
        if(json.layoutsPath == null) return "_layouts";
        return json.layoutsPath;
    }

    public function getAssetsPath(): String
    {
        if(json.assetsPath == null) return "_assets";
        return json.assetsPath;
    }

}