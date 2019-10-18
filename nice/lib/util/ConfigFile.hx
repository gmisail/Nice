package nice.lib.util;

import sys.io.File;

import yaml.Yaml;
import yaml.Parser;

typedef ConfigData = {
    var paths: {
        var assets : String;
        var posts : String;
        var pages : String;
        var layouts : String;
        var output : String;
    }
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
        if(data == null || data.paths == null || data.paths.output == null) return "_public";
        return data.paths.output;
    }

    public function getPostsPath(): String
    {
        if(data == null || data.paths == null || data.paths.posts == null) return "_posts";
        return data.paths.posts;
    }

    public function getPagesPath(): String
    {
        if(data == null || data.paths == null || data.paths.pages == null) return "_pages";
        return data.paths.pages;
    }

    public function getLayoutsPath(): String
    {
        if(data == null || data.paths == null || data.paths.layouts == null) return "_layouts";
        return data.paths.layouts;
    }

    public function getAssetsPath(): String
    {
        if(data == null || data.paths == null || data.paths.assets == null) return "_assets";
        return data.paths.assets;
    }

}