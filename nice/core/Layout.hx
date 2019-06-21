package nice.core;

import haxe.Json;
import nice.core.Post;

class Layout
{
    public var name : String;
    public var content : String;

    public function new(name : String, content : String)
    {
        this.name = name;
        this.content = content;
    }

    public function compilePost(post : Post, posts : Collection, pages : Collection, globals : Json) : String
    {
        return compile({title: post.title, body: post.compile(), date: post.dateStamp.render(), posts: posts.getItems(), pages: pages.getItems(), globals : globals});
    }

    public function compile(context : {}) : String
    {
        return Mustache.render(content, context);
    }
}