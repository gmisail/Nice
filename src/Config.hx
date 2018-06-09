package;

import sys.FileSystem;
import sys.io.File;

import haxe.Json;

typedef ConfigFile = {
    paths : {
        publicDir : String,
        post : String,
        layout : String,
        pages : String,
        assets : String
    }
}

class Config
{
    public static var projectDirectory : String;

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

        #if !dev
            projectDirectory = Sys.args().pop();
            Sys.setCwd(projectDirectory);
        #end

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
        
        publicFolder = FileSystem.readDirectory(config.paths.publicDir);
        postsFolder = FileSystem.readDirectory(config.paths.post);
        layoutFolder = FileSystem.readDirectory(config.paths.layout);
        pagesFolder = FileSystem.readDirectory(config.paths.pages);
        assetsFolder = FileSystem.readDirectory(config.paths.assets);

        onLoad();
    }
}