package nice.lib.util;

import sys.io.File;

import yaml.Yaml;
import yaml.Parser;

typedef ConfigData = {
    var assetsPath : String;
    var postsPath : String;
    var pagesPath : String;
    var layoutsPath : String;
    var outputPath : String;
    var variables: {};
}

/*
    Manages the config.yaml file and helps load properties
*/
class ConfigFile
{
    private var path : String;
    private var content : String;
    private var data : ConfigData;

    public function new(path : String)
    {
        this.path = path;
        this.content = File.getContent(path);

        if(this.content.length != 0)
        {
            this.data = Yaml.read(path, Parser.options().useObjects());
        }
        else
        {
            this.data = null;
        }
    }

    public function getVariables() : Dynamic
    {
        if (data == null || data.variables == null) return {};
        else return data.variables;
    }

    public function getOutputPath() : String
    {
        if(data == null || data.outputPath == null) return "_public";
        return data.outputPath;
    }

    public function getPostsPath(): String
    {
        if(data == null || data.postsPath == null) return "_posts";
        return data.postsPath;
    }

    public function getPagesPath(): String
    {
        if(data == null || data.pagesPath == null) return "_pages";
        return data.pagesPath;
    }

    public function getLayoutsPath(): String
    {
        if(data == null || data.layoutsPath == null) return "_layouts";
        return data.layoutsPath;
    }

    public function getAssetsPath(): String
    {
        if(data == null || data.assetsPath == null) return "_assets";
        return data.assetsPath;
    }

}