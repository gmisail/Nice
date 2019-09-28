package nice.lib;

import nice.lib.core.Layout;
import haxe.Json;
import haxe.ds.ArraySort;

import nice.lib.core.Directory;
import nice.lib.core.Post;

import nice.cli.Output;

class Collection
{
    private var directory : Directory;
    private var items : Array<Post>; 
    private var visible : Array<Post>; /* posts have a 'state' property which determines whether or not it can be exposed to HTML. */

    public function new(dir : String)
    {
        directory = new Directory(dir);
        items = [];
        visible = [];
        
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
        //Sortbydate();
        sortByOrder();

        return visible;
    }

    public function getAll() : Array<Post>
    {
        return items;
    }
    
    /*
    public function sortByDate()
    {
        ArraySort.sort(visible, function(itemA, itemB) : Int {
            if (itemA.dateStamp.compare(itemB.dateStamp)) return -1;
            else if (itemB.dateStamp.compare(itemA.dateStamp)) return 1;
            return 0;
        });
    }
    */

    public function sortByOrder()
    {
        ArraySort.sort(visible, function(itemA, itemB) : Int {
            if (itemA.getOrder() < itemB.getOrder()) return -1;
            else if (itemA.getOrder() > itemB.getOrder()) return 1;
            return 0;
        });
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