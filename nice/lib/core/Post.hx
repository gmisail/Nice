package nice.lib.core;

import sys.FileSystem;
import sys.io.File;

import yaml.Yaml;

import nice.cli.Output;

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
        
        var frontmatterContent : Array<String> = this.content.split("---");

        this.createBody(frontmatterContent);

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

        /**
         * Date does not exist so set it to the time of compilation
         */
        if(date == null || !Std.is(date, Date)) 
        {
            date = Date.now();
        }

        /**
         * Date exists, but it is not of type 'Date'
         */
        else if(date != null && !Std.is(date, Date))
        {
            Output.warning("Unknown 'Date' type. Output may be unexpected. (" + this.name + ")");
        }

        if(order == null) order = -1;
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

    /**
     * Get the post's date stamp. If it does not exist, it returns the date of compilation
     * @return Date
     */
    public function getDate() : Date
    {
        return date;
    }

    /**
     * Get the title of the current post / page
     * @return String
     */
    public function getTitle() : String
    {
        return title;
    }

    /**
     * Get whether or not the current post is visible, invisible, etc.
     * @return String
     */
    public function getState() : String
    {
        return state;
    }

    /**
     * Get the name of the current file
     * @return String
     */
    public function getName() : String
    {
        return name;
    }

    /**
     * Get the order of the file, if given. If not, return -1.
     * @return Int
     */
    public function getOrder() : Int
    {
        return order;
    }

    /**
     * Get the current post's template
     * @return String
     */
    public function getTemplate() : String
    {
        return template;
    }

    /**
    *    SORTING
    */
    public static function compare(a : Post, b : Post) : Int
    {
        if(a.getDate().getFullYear() < b.getDate().getFullYear()) return -1;                 
        else if(a.getDate().getFullYear() == b.getDate().getFullYear() && a.getDate().getMonth() < b.getDate().getMonth()) return -1;      
        else if(a.getDate().getFullYear() == b.getDate().getFullYear() && a.getDate().getMonth() == b.getDate().getMonth() && a.getDate().getDate() < b.getDate().getDate()) return -1;
        else if(a.getDate().getFullYear() == b.getDate().getFullYear() && a.getDate().getMonth() == b.getDate().getMonth() && a.getDate().getDate() == b.getDate().getDate()) return 0;

        return 1;
    }

    public static function compareReverse(a : Post, b : Post) : Int
    {
        if(a.getDate().getFullYear() > b.getDate().getFullYear()) return -1;                 
        else if(a.getDate().getFullYear() == b.getDate().getFullYear() && a.getDate().getMonth() > b.getDate().getMonth()) return -1;      
        else if(a.getDate().getFullYear() == b.getDate().getFullYear() && a.getDate().getMonth() == b.getDate().getMonth() && a.getDate().getDate() > b.getDate().getDate()) return -1;
        else if(a.getDate().getFullYear() == b.getDate().getFullYear() && a.getDate().getMonth() == b.getDate().getMonth() && a.getDate().getDate() == b.getDate().getDate()) return 0;

        return 1;
    }

    public static function compareOrder(a : Post, b : Post) : Int
    {
        if(a.getOrder() < b.getOrder()) return -1;                 
        else if(a.getOrder() > b.getOrder()) return 1;

        return 0;
    }

    private function createBody(frontmatterContent : Array<String>) : Void
    {
        if(frontmatterContent.length > 2)
        {
            var current : String = "";
            for(i in 2...frontmatterContent.length)
            {
                if(i != 2)
                {
                    current += " --- ";
                }

                current += frontmatterContent[i];
            }

            this.body = current;
        }
        else
        {
            this.body = frontmatterContent[2];
        }
    }
}