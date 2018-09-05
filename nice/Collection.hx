package nice;

import nice.core.Directory;
import nice.core.Post;

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

    public function render(layouts : Layouts, posts : Collection, pages : Collection, saveTo : String, ?sortedByOrder : Bool = false) 
    {
        if(sortedByOrder)
        {
            sortByOrder();
        }

        for(item in getAll())
        {
            var template = layouts.getLayout(item.template);
            if(template == null)
            {
                template = layouts.getLayout("index.html");
            }

            var renderedPost = template.compilePost(item, posts, pages);
            item.save(saveTo, renderedPost);
        }
    }
}