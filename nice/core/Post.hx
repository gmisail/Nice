package nice.core;

import sys.io.File;
import yaml.Yaml;

import nice.util.DateStamp;

class Post
{
    public var name : String;
    public var content : String;
    public var body : String;
    public var title : String;
    public var date : Int;
    public var tags : Array<String>;
    public var template : String;
    public var state : String;
    public var language : String;

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

        if(tags == null)
        {
            tags = [];
        }

        if(template == null)
        {
            template = "index.html";
        }

        if(state == null)
        {
            state = "visible";
        }

        if(language == null)
        {
            language = "html";
        }

        if(date == null)
        {
            date = 20001109;
        }

        dateStamp = new DateStamp(date);

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