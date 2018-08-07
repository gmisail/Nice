package nice.core;

import sys.io.File;
import yaml.Yaml;

class Post
{
    public var name : String;
    public var content : String;
    public var body : String;
    public var title : String;
    public var date : String;
    public var tags : Array<String>;
    public var template : String;
    public var state : String;
    public var language : String;

    public var frontmatter : Dynamic;

    public function new(name : String, content : String)
    {
        this.name = name;
        this.content = content;
        
        var frontmatterContent = this.content.split("---");
        this.frontmatter = Yaml.parse(frontmatterContent[1]);

        this.title = frontmatter.get("title");
        this.date = frontmatter.get("date");
        this.tags = frontmatter.get("tags");
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