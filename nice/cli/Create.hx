package nice.cli;

import sys.io.File;

class Create
{
    private static var DEFAULT_POST_FRONTMATTER : String = "---\ntitle: New Post\n---\n";
    private static var DEFAULT_PAGE_FRONTMATTER : String = "---\ntitle: New Page\n---\n";
    
    private static var DEFAULT_CONTENT : String = "Add some content here.";

    public static function post(name : String)
    {
        File.saveContent("_posts/" + name + ".html", DEFAULT_POST_FRONTMATTER + DEFAULT_CONTENT);
    }

    public static function page(name : String)
    {
        File.saveContent("_pages/" + name + ".html", DEFAULT_PAGE_FRONTMATTER + DEFAULT_CONTENT);
    }
}