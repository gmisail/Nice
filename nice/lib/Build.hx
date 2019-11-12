package nice.lib;

import sys.FileSystem;
import sys.io.File;

import nice.fs.Directory;

import nice.lib.*;
import nice.lib.util.Platform;
import nice.lib.util.ConfigFile;

class Build
{
    private static var assets : Assets;
    private static var posts : Collection;
    private static var layouts : Layouts;
    private static var pages : Collection;

    private static var config : ConfigFile;

    public static function process()
    {
        config = new ConfigFile("config.yaml");

        posts = new Collection(config.getPostsPath(), config.getSortPosts());
        pages = new Collection(config.getPagesPath(), config.getSortPages());
        layouts = new Layouts(config.getLayoutsPath());
        assets = new Assets(config.getAssetsPath());
    }

    public static function compile()
    {
        clean(config.getOutputPath());

        Directory.create(config.getOutputPath());
        Directory.create(config.getOutputPath() + "/_posts");
        Directory.create(config.getOutputPath() + "/_assets");

        if(config.getPlatform() == Platform.GITHUB_PAGES)
        {
            File.saveContent(config.getOutputPath() + "/.nojekyll", "");
        }

        assets.copy();

        posts.render(layouts, posts, pages, config.getVariables(), config.getOutputPath() + "/_posts");
        pages.render(layouts, posts, pages, config.getVariables(), config.getOutputPath());
    }

    public static function clean(path : String)
    {
        if (FileSystem.exists(path) && FileSystem.isDirectory(path))
        {
            var entries = FileSystem.readDirectory(path);
            for (entry in entries)
            {
                if (FileSystem.isDirectory(path + '/' + entry))
                {
                    clean(path + '/' + entry);
                    FileSystem.deleteDirectory(path + '/' + entry);
                }
                else
                {
                    FileSystem.deleteFile(path + '/' + entry);
                }
            }
        }
    }
}