package;

import Post;

import haxe.Template;

import sys.FileSystem;
import sys.io.File;

class Generator
{
    public static var layout : Template;
    public static var posts : Array<Post>;
    public static var pages : Array<Post>;

    public static function init() : Void
    {
        posts = [];
        pages = [];
        
        cleanPublic();
        loadAssets();
        compileLayout();

        loadPages();
        loadPosts();
        
        compileSpecial();
        compileFinish();
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

    private static function compileSpecial() : Void
    {
        Sys.println("Nice -> Compiling home");

        var homePath = '${Config.config.paths.pages}/home.html';
        var output = Post.compile(layout, Post.load(homePath, "home.html"));

        File.saveContent('${Config.config.paths.publicDir}/index.html', output);

        Sys.println("Nice -> Compiling 404");

        var notFoundPath = '${Config.config.paths.pages}/404.html';
        var output = Post.compile(layout, Post.load(notFoundPath, "404.html"));

        File.saveContent('${Config.config.paths.publicDir}/404.html', output);
    }

    private static function loadPosts() : Void
    {
        Sys.println("Nice -> Loading posts");
        
        var postsPath = '${Config.config.paths.publicDir}/posts';
        FileSystem.createDirectory(postsPath);

        for(file in Config.postsFolder)
        {
            var data = Post.load('${Config.config.paths.post}/${file}', file);
            posts.push(data);
        }
    }

    private static function loadPages() : Void
    {
        Sys.println("Nice -> Loading pages");
        
        var pagesPath = '${Config.config.paths.publicDir}/pages';
        FileSystem.createDirectory(pagesPath);

        for(file in Config.pagesFolder)
        {
            if(file != "home.html" && file != "404.html") /* home are 404 are reserved for the index.html and 404.html pages. */
            {
                var data = Post.load('${Config.config.paths.pages}/${file}', file);
                pages.push(data);
            }
        }
    }

    /*
        We have everything loaded at this point. Because we have all of the updated information, 
        we can compile our pages and posts.
    */
    private static function compileFinish() : Void
    {
        Sys.println("Nice -> Compiling posts");

        var postsPath = '${Config.config.paths.publicDir}/posts';
        for(post in posts)
        {
            var output = Post.compile(layout, post);
            File.saveContent('${postsPath}/${post.name}', output);
        }

        Sys.println("Nice -> Compiling pages");

        var pagesPath = '${Config.config.paths.publicDir}/pages';
        for(page in pages)
        {
            var output = Post.compile(layout, page);
            File.saveContent('${pagesPath}/${page.name}', output);
        }
    }
}