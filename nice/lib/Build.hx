package nice.lib;

import sys.FileSystem;
import nice.lib.util.ConfigFile;
import nice.lib.core.Post;
import nice.lib.core.Layout;
import nice.lib.core.Directory;
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
        config = new ConfigFile("config.json");

        posts = new Collection(config.getPostsPath());
        pages = new Collection(config.getPagesPath());
        layouts = new Layouts(config.getLayoutsPath());
        assets = new Assets(config.getAssetsPath());
    }

    public static function compile()
    {
        clean("_public");

        Directory.create("_public");
        Directory.create("_public/_posts");
        Directory.create("_public/_assets");

        assets.copy();

        posts.render(layouts, posts, pages, config.getVariables(), config.getOutputPath() + "/_posts");
        pages.render(layouts, posts, pages, config.getVariables(), config.getOutputPath());
    }

    public static function clean(path : String)
    {
        if (FileSystem.exists(path) && sys.FileSystem.isDirectory(path))
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