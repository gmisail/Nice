package;

import haxe.Json;
import haxe.Template;

import sys.io.File;

typedef PostData = {
    title : String,
    markdown : Bool
};

class Post
{
    public var title : String;
    public var data : String;
    public var name : String;

    public function new()
    {

    }

    public static function load(filePath : String, name : String) : Post
    {
        var postSource = File.getContent(filePath);

        var postSections = postSource.split("---"); //this will cut out the Json data. The data will be in [1], and the post will be in [2]
        var headerData = postSections[1];
        var postData = postSections[2];
        var jsonData : PostData = Json.parse(headerData);

        var post = new Post();
        post.title = jsonData.title;
        post.data = postData;
        post.name = name;

        if(jsonData.markdown != null && jsonData.markdown)
        {
            post.name = (name.split(".")[0]) + ".html";
            post.data = Markdown.markdownToHtml(postData);
        }

        return post;
    }

    public static function compile(layout : Template, post : Post) : Dynamic
    {
        return layout.execute({title: post.title, body: post.data, posts: Generator.posts, pages: Generator.pages});
    }
}