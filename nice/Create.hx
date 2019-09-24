package nice;

import sys.io.File;

import nice.lib.core.Directory;

/*
 *  Manages the creation of new posts, pages, layouts, etc.  
 */

class Create
{
    private static var DEFAULT_POST_FRONTMATTER : String = "---\ntitle: New Post\n---\n";
    private static var DEFAULT_PAGE_FRONTMATTER : String = "---\ntitle: New Page\n---\n";

    /* default post / page content */
    private static var DEFAULT_CONTENT : String = "Add some content here.";

    /* this is wicked messy, think of a better way to hardcode the template data */
    private static var DEFAULT_LAYOUT : String = '<html><body><h1>My cool blog!</h1><h3>{{title}}</h3><p>{{{body}}}</p><hr><h2>Other posts</h2><ul>{{#posts}}<li><a href="/_posts/{{name}}">{{title}}</a></li>{{/posts}}</ul></body></html>';

    public static function post(name : String)
    {
        File.saveContent("_posts/" + name + ".html", DEFAULT_POST_FRONTMATTER + DEFAULT_CONTENT);
    }

    public static function page(name : String)
    {
        File.saveContent("_pages/" + name + ".html", DEFAULT_PAGE_FRONTMATTER + DEFAULT_CONTENT);
    }

    public static function layout(name : String)
    {
        File.saveContent("_layouts/" + name + ".html", DEFAULT_LAYOUT);
    }

    public static function project()
    {
        File.saveContent("config.json", "{}");
        
        Directory.create("_assets");
        Directory.create("_pages");
        Directory.create("_posts");
        Directory.create("_layouts");
        Directory.create("_public");
        
        layout("index");
        page("index");
        post("MyFirstPost");
    }
}