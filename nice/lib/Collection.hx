package nice.lib;

import haxe.Json;

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
                if(post.state != 'hidden')
                {
                    visible.push(post);
                }
            }
        }
    }

    public function getItems() : Array<Post>
    {
        sortByDate();
        sortByOrder();

        return visible;
    }

    public function getAll() : Array<Post>
    {
        return items;
    }
    
    public function sortByDate()
    {
        haxe.ds.ArraySort.sort(visible, function(itemA, itemB) : Int {
            if (itemA.date > itemB.date) return -1;
            else if (itemA.date < itemB.date) return 1;
            return 0;
        });
    }

    public function sortByOrder()
    {
        haxe.ds.ArraySort.sort(visible, function(itemA, itemB) : Int {
            if (itemA.order < itemB.order) return -1;
            else if (itemA.order > itemB.order) return 1;
            return 0;
        });
    }

    public function render(layouts : Layouts, posts : Collection, pages : Collection, globals : Json, saveTo : String)
    {
        for(item in getAll())
        {
            var template = layouts.getLayout(item.template);
            if(template == null)
            {
                template = layouts.getLayout("index.html");
            }

            Output.text("Compiling " + item.name);

            var renderedPost = template.compilePost(item, posts, pages, globals);
            item.save(saveTo, renderedPost);
        }
    }
}