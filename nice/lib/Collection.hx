package nice.lib;

import nice.lib.core.Layout;
import haxe.Json;
import haxe.ds.ArraySort;

import nice.fs.Directory;

import nice.lib.Layouts;
import nice.lib.Collection;
import nice.lib.core.Post;

import nice.cli.Output;

enum SortType
{
    ORDER;
    DATE_NEWEST_TO_OLDEST;
    DATE_OLDEST_TO_NEWEST;
}

class Collection
{
    private var directory : Directory;
    private var items : Array<Post>; 
    private var visible : Array<Post>; /* posts have a 'state' property which determines whether or not it can be exposed to HTML. */
    private var sort : String;

    public function new(dir : String, ?sort : String = "none")
    {
        this.directory = new Directory(dir);
        this.items = [];
        this.visible = [];
        this.sort = sort;
        
        for(item in directory.files())
        {
            if(item != ".DS_Store") /* hidden file on macOS */
            {
                var post = new Post(item, directory.getFile(item));
                items.push(post);
                if(post.getState() != 'hidden')
                {
                    visible.push(post);
                }
            }
        }
    }

    public function getItems() : Array<Post>
    {
        switch(sort)
        {
            case "newest-to-oldest":
                visible.sort(Post.compareReverse);
            case "oldest-to-newest":
                visible.sort(Post.compare);
            case "order":
                visible.sort(Post.compareOrder);
            default:
                sort = "none";
        }

        return visible;
    }

    public function getAll() : Array<Post>
    {
        return items;
    }
    
    public function render(layouts : Layouts, posts : Collection, pages : Collection, globals : Json, saveTo : String)
    {
        for(item in getAll())
        {
            var layout : Layout = layouts.getLayout(item.getTemplate());
            if(layout == null)
            {
                if(layouts.getLayout("index.html") == null)
                {
                    Output.error("You must have a default layout (index.html) defined!");
                    Sys.exit(1);
                }

                layout = layouts.getLayout("index.html");
            }

            Output.text("Compiling " + item.getName());

            var renderedPost = layout.compilePost(item, posts, pages, globals);
            item.save(saveTo, renderedPost);
        }
    }
}