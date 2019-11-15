package nice.lib;

import nice.lib.core.Layout;
import haxe.Json;
import haxe.ds.ArraySort;

import nice.fs.Directory;

import nice.lib.Layouts;
import nice.lib.Collection;
import nice.lib.core.Post;

import nice.rss.RSS;

import nice.cli.Output;

enum SortType
{
    ORDER;
    DATE_NEWEST_TO_OLDEST;
    DATE_OLDEST_TO_NEWEST;
}

class Collection
{
    private var _directory : Directory;
    private var _items : Array<Post>; 
    private var _visible : Array<Post>; /* posts have a 'state' property which determines whether or not it can be exposed to HTML. */
    private var _sort : String;

    public function new(dir : String, ?sort : String = "none")
    {
        this._directory = new Directory(dir);
        this._items = [];
        this._visible = [];
        this._sort = sort;
        
        for(item in _directory.files())
        {
            if(item != ".DS_Store") /* hidden file on macOS */
            {
                var post = new Post(item, _directory.getFile(item));
                _items.push(post);
                if(post.getState() != 'hidden')
                {
                    _visible.push(post);
                }
            }
        }
    }

    /**
     * Returns an array of all of the sorted, visible posts
     * @return Array<Post>
     */
    public function getItems() : Array<Post>
    {
        switch(_sort)
        {
            case "newest-to-oldest":
                _visible.sort(Post.compareReverse);
            case "oldest-to-newest":
                _visible.sort(Post.compare);
            case "order":
                _visible.sort(Post.compareOrder);
            default:
                _sort = "none";
        }

        return _visible;
    }

    /**
     * Returns an array of all posts (includes visible & non-visible)
     * @return Array<Post>
     */
    public function getAll() : Array<Post>
    {
        return _items;
    }
    
    /**
     * Compiles every post / page stored in a collection and writes it to its respective directory
     * @param layouts 
     * @param posts 
     * @param pages 
     * @param globals 
     * @param saveTo 
     */
    public function render(layouts : Layouts, posts : Collection, pages : Collection, globals : Json, saveTo : String)
    {
        var rss = new RSS();

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

            rss.add(item.getTitle());

            var renderedPost = layout.compilePost(item, posts, pages, globals);
            item.save(saveTo, renderedPost);
        }

        Output.text(rss.generate());
    }
}