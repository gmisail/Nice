package nice.lib.util;

import sys.FileSystem;
import sys.io.File;

import yaml.Yaml;
import yaml.Parser;

import nice.cli.Output;
import nice.lib.core.Post;
import nice.lib.util.Platform;

typedef ConfigData = {
    var paths: {
        var assets : String;
        var posts : String;
        var pages : String;
        var layouts : String;
        var output : String;
    }
    
    var variables: {};

    var platform: String;

    var sortPosts: String;
    var sortPages: String;
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

        if(FileSystem.exists(path))
        {
            this.content = File.getContent(path);
        }
        else
        {
            this.content = "";

            Output.error("Cannot find config.yaml!");
            Sys.exit(1);
        }

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

    public function getPlatform(): String
    {
        if(data == null || data.platform == null) return Platform.DEFAULT;
        else if(data.platform == "github pages") return Platform.GITHUB_PAGES;
        else return Platform.DEFAULT;
    }

    /*public function getSortPages() : SortType
    {
        if(data == null || data.sortPages == null) return true;
        else return data.sortPages;
    }

    public function getSortPosts() : SortType
    {
        if(data == null || data.sortPosts == null) return Post.ORDER;
        else return data.sortPosts;
    }*/
}