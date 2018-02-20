package;

import sys.FileSystem;
import sys.io.File;

import haxe.Json;

typedef ConfigFile = {
    publicPath : String,
    postPath: String,
    layoutPath: String,
    pagesPath: String,
    assetsPath: String
}

class Config
{
    public static var config : ConfigFile;
    public static var configPath : String = "config.json";

    public static var publicFolder : Array<String>;
    public static var postsFolder : Array<String>;
    public static var layoutFolder : Array<String>;
    public static var pagesFolder : Array<String>;
    public static var assetsFolder : Array<String>;
    
    private static var onLoad : Void->Void;

    public static function load(callback : Void->Void)
    {      
        onLoad = callback;

        if(FileSystem.exists(configPath))
        {
            Sys.println("Nice -> Loading config.json");
            
            config = Json.parse(File.getContent(configPath));
            loadPaths();
        }
        else
        {
            Sys.println("Nice -> Cannot find config.json!");
        }
    }

    public static function loadPaths()
    {
        Sys.println("Nice -> Loading directories");
        
        publicFolder = FileSystem.readDirectory(config.publicPath);
        postsFolder = FileSystem.readDirectory(config.postPath);
        layoutFolder = FileSystem.readDirectory(config.layoutPath);
        pagesFolder = FileSystem.readDirectory(config.pagesPath);
        assetsFolder = FileSystem.readDirectory(config.assetsPath);

        onLoad();
    }
}