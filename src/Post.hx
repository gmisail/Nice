package;

import haxe.Json;
import haxe.Template;

import sys.io.File;

typedef PostData = {
    title : String,
    markdown : Bool,
    date : String
};

class Post
{
    public var title : String;
    public var data : String;
    public var name : String;
    public var date : String;
    public var kind : FileType;

    public function new()
    {

    }

    public static function load(filePath : String, name : String, kind : FileType) : Post
    {
        var postSource = File.getContent(filePath);
        var postSections = postSource.split("---"); //this will cut out the Json data. The data will be in [1], and the post will be in [2]
        var headerData = postSections[1];
        var postData = postSections[2];
        var jsonData : PostData = Json.parse(headerData);

        if(jsonData == null)
        {
            Sys.println("Nice -> Error loading JSON.");
        }

        var post = new Post();
        post.title = jsonData.title;
        
        if(jsonData.date != null)
            post.date = jsonData.date;
        else
            post.date = "";

        post.kind = kind;
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
        return layout.execute({title: post.title, body: post.data, posts: Generator.posts, pages: Generator.pages, date: post.date});
    }
}