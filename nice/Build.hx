package nice;

import nice.core.Post;
import nice.core.Layout;
import nice.core.Directory;

class Build
{
    private static var assets : Assets;
    private static var posts : Collection;
    private static var layouts : Layouts;
    private static var pages : Collection;

    public static function process()
    {
        posts = new Collection("_posts");
        pages = new Collection("_pages");
        layouts = new Layouts();
        assets = new Assets();
    }

    public static function compile()
    {
        clean("_public");

        Directory.create("_public");
        Directory.create("_public/_posts");
        Directory.create("_public/_assets");

        assets.copy();

        posts.render(layouts, posts, pages, "_public/_posts");
        pages.render(layouts, posts, pages, "_public");
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