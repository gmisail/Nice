package nice.lib.core;

import sys.io.File;
import yaml.Yaml;

import nice.lib.util.DateStamp;

class Post
{
    public var name : String;           // Name of post's file
    public var content : String;        // The post's total content
    public var body : String;           // The post body / text
    public var title : String;          // Title of the post
    public var date : Int;              // Date the post was created
    public var tags : Array<String>;    // Post tags
    public var template : String;       // The template that the post uses
    public var state : String;          // Whether or not the page is hidden or not
    public var language : String;       // Markdown or HTML?
    public var order : Int;             // What order do you want the pages to be in?

    public var frontmatter : Dynamic;
    public var dateStamp : DateStamp;

    public function new(name : String, content : String)
    {
        this.name = name;
        this.content = content;
        
        var frontmatterContent = this.content.split("---");
        this.frontmatter = Yaml.parse(frontmatterContent[1]);

        this.title = frontmatter.get("title");
        this.tags = frontmatter.get("tags");
        this.date = frontmatter.get("date");
        this.template = frontmatter.get("template");
        this.state = frontmatter.get("state");
        this.language = frontmatter.get("language");
        this.order = frontmatter.get("order");

        if(tags == null) tags = [];
        if(template == null) template = "index.html";
        if(state == null) state = "visible";
        if(language == null) language = "html";

        var actualDate = true;

        if(date == null)
        {
            date = 10000000;
            actualDate = false;
        }

        dateStamp = new DateStamp(date, actualDate);

        if(order == null) order = -1;

        this.body = frontmatterContent[2];
    }

    public function compile() : String
    {
        switch(language)
        {
            case "html":
                return body;
            case "markdown":
                return Markdown.markdownToHtml(body);
            default:
                return body;
        }
    }

    public function save(path : String, rendered : String)
    {
        File.saveContent(path + "/" + name, rendered);
    }
}