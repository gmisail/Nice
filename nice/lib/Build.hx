package nice.lib;

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

    private static var globalVariables : ConfigFile;

    public static function process()
    {
        posts = new Collection("_posts");
        pages = new Collection("_pages");
        layouts = new Layouts();
        assets = new Assets();

        globalVariables = new ConfigFile("config.json");
    }

    public static function compile()
    {
        clean("_public");

        Directory.create("_public");
        Directory.create("_public/_posts");
        Directory.create("_public/_assets");

        assets.copy();

        posts.render(layouts, posts, pages, globalVariables.getData(), "_public/_posts");
        pages.render(layouts, posts, pages, globalVariables.getData(), "_public");
    }

    public static function clean(path : String)
    {
        if (sys.FileSystem.exists(path) && sys.FileSystem.isDirectory(path))
        {
            var entries = sys.FileSystem.readDirectory(path);
            for (entry in entries)
            {
                if (sys.FileSystem.isDirectory(path + '/' + entry))
                {
                    clean(path + '/' + entry);
                    sys.FileSystem.deleteDirectory(path + '/' + entry);
                }
                else
                {
                    sys.FileSystem.deleteFile(path + '/' + entry);
                }
            }
        }
    }
}