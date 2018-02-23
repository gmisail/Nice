package;

import Post;

import haxe.Template;

import sys.FileSystem;
import sys.io.File;

class Generator
{
    public static var layout : Template;
    public static var posts : Array<Post>;

    public static function init() : Void
    {
        posts = [];
        
        cleanPublic();
        loadAssets();
        compileLayout();
        compilePosts();
        compileHome();
    }

    private static function recursiveDelete(path : String) : Void
    {
        if (FileSystem.exists(path) && FileSystem.isDirectory(path))
        {
            var entries = FileSystem.readDirectory(path);
            for (entry in entries)
            {
                if (FileSystem.isDirectory(path + '/' + entry))
                {
                    recursiveDelete(path + '/' + entry);
                    FileSystem.deleteDirectory(path + '/' + entry);
                }
                else
                {
                    FileSystem.deleteFile(path + '/' + entry);
                }
            }
        }
    }

    private static function cleanPublic() : Void
    {
        Sys.println("Nice -> Cleaning public directory");
        
        for(file in Config.publicFolder)
        {
            recursiveDelete(Config.config.paths.publicDir + "/" + file);
        }
    }

    private static function loadAssets() : Void
    {
        Sys.println("Nice -> Loading assets");

        FileSystem.createDirectory('${Config.config.paths.publicDir}/assets');

        for(file in Config.assetsFolder)
        {
            File.copy('${Config.config.paths.assets}/${file}', '${Config.config.paths.publicDir}/assets/${file}');
        }
    }

    private static function compileLayout() : Void
    {
        Sys.println("Nice -> Compiling layout");
        
        for(file in Config.layoutFolder)
        {
            var source = File.getContent('${Config.config.paths.layout}/${file}');
            layout = new Template(source);
        }
    }

    private static function compileHome() : Void
    {
        Sys.println("Nice -> Compiling home");

        var homePath = '${Config.config.paths.pages}/home.html';
        var output = Post.compile(layout, Post.load(homePath, "home.html"));

        File.saveContent('${Config.config.paths.publicDir}/index.html', output);
    }

    private static function compilePosts() : Void
    {
        Sys.println("Nice -> Compiling posts");
        
        var postsPath = '${Config.config.paths.publicDir}/posts';
        FileSystem.createDirectory(postsPath);

        for(file in Config.postsFolder)
        {
            var data = Post.load('${Config.config.paths.post}/${file}', file);
            posts.push(data);
        }

        for(post in posts)
        {
            var output = Post.compile(layout, post);
            File.saveContent('${postsPath}/${post.name}', output);
        }
    }
}