package nice.core;

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

    public function compilePost(post : Post, posts : Collection, pages : Collection) : String
    {
        return compile({title: post.title, body: post.body, posts: posts.getItems(), pages: pages.getItems()});
    }

    public function compile(context : {}) : String
    {
        return Mustache.render(content, context);
    }
}