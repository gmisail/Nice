package nice.lib.core;

import sys.FileSystem;
import sys.io.File;
import yaml.Yaml;

class Post
{
    private var name : String;           // Name of post's file
    private var content : String;        // The post's total content
    private var body : String;           // The post body / text
    private var title : String;          // Title of the post
    private var date : Date;              // Date the post was created
    private var tags : Array<String>;    // Post tags
    private var template : String;       // The template that the post uses
    private var state : String;          // Whether or not the page is hidden or not
    private var language : String;       // Markdown or HTML?
    private var order : Int;             // What order do you want the pages to be in?

    private var frontmatter : Dynamic;

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
        if(date == null) date = Date.now();
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
        if(FileSystem.exists(path))
        {
            File.saveContent(path + "/" + name, rendered);
        }
        else
        {
            FileSystem.createDirectory(path + "/");
            File.saveContent(path + "/" + name, rendered);
        }
    }

    public function getDate() : Date
    {
        return date;
    }

    public function getTitle() : String
    {
        return title;
    }

    public function getState() : String
    {
        return state;
    }

    public function getName() : String
    {
        return name;
    }

    public function getOrder() : Int
    {
        return order;
    }

    public function getTemplate() : String
    {
        return template;
    }
}