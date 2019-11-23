package nice.lib.core;

import sys.FileSystem;
import sys.io.File;

import yaml.Yaml;

import nice.cli.Output;

class Post
{
    var _name : String;           // Name of post's file
    var _content : String;        // The post's total content
    var _body : String;           // The post body / text
    var _title : String;          // Title of the post
    var _date : Date;             // Date the post was created
    var _tag : String;            // Post tags
    var _template : String;       // The template that the post uses
    var _state : String;          // Whether or not the page is hidden or not
    var _language : String;       // Markdown or HTML?
    var _order : Int;             // What order do you want the pages to be in?

    var _frontmatter : Dynamic;

    public function new(name : String, content : String)
    {
        this._name = name;
        this._content = content;
        
        var frontmatterContent : Array<String> = this._content.split("---");
        
        this._frontmatter = Yaml.parse(frontmatterContent[1]);
        this._createBody(frontmatterContent);

        this._title = _frontmatter.get("title");
        this._tag = _frontmatter.get("tag");
        this._date = _frontmatter.get("date");
        this._template = _frontmatter.get("template");
        this._state = _frontmatter.get("state");
        this._language = _frontmatter.get("language");
        this._order = _frontmatter.get("order");
        this._tag = _frontmatter.get("tag");

        if(_template == null) _template = "index.html";
        if(_state == null) _state = "visible";
        if(_language == null) _language = "html";

        /**
         * Date does not exist so set it to the time of compilation
         */
        if(_date == null || !Std.is(_date, Date)) 
        {
            _date = Date.now();
        }

        /**
         * Date exists, but it is not of type 'Date'
         */
        else if(_date != null && !Std.is(_date, Date))
        {
            Output.warning("Unknown 'Date' type. Output may be unexpected. (" + this._name + ")");
        }

        if(_order == null) _order = -1;
    }

    /**
     * Compiles the post and returns the output as a String
     * @return String
     */
    public function compile() : String
    {
        switch(_language)
        {
            case "html":
                return _body;
            case "markdown":
                return Markdown.markdownToHtml(_body);
            default:
                return _body;
        }
    }

    /**
     * Saves the output to the filesystem. If the path doesn't exist, create a new path
     * @param path 
     * @param rendered 
     */
    public function save(path : String, rendered : String)
    {
        if(FileSystem.exists(path))
        {
            File.saveContent(path + "/" + _name, rendered);
        }
        else
        {
            FileSystem.createDirectory(path + "/");
            File.saveContent(path + "/" + _name, rendered);
        }
    }

    /**
     * Get the post's date stamp. If it does not exist, it returns the date of compilation
     * @return Date
     */
    public function getDate() : Date
    {
        return _date;
    }

    /**
     * Get the title of the current post / page
     * @return String
     */
    public function getTitle() : String
    {
        return _title;
    }

    /**
     * Get whether or not the current post is visible, invisible, etc.
     * @return String
     */
    public function getState() : String
    {
        return _state;
    }

    /**
     * Get the name of the current file
     * @return String
     */
    public function getName() : String
    {
        return _name;
    }

    /**
     * Get the order of the file, if given. If not, return -1.
     * @return Int
     */
    public function getOrder() : Int
    {
        return _order;
    }

    /**
     * Get the current post's template
     * @return String
     */
    public function getTemplate() : String
    {
        return _template;
    }

    /**
     * Get the current post's tag
     * @return String
     */
    public function getTag() : String
    {
        return _tag;
    }

    /**
     * Set the title of the current post / page
     * @param title 
     */
    public function setTitle(title : String) : Void
    {
        this._title = title;
    }

    /**
     * Set the body content
     * @param content 
     */
    public function setBody(content : String) : Void
    {
        this._body = content;
    }

    /**
     * Sort from least to greatest
     * @param a 
     * @param b 
     * @return Int
     */
    public static function compare(a : Post, b : Post) : Int
    {
        if(a.getDate().getFullYear() < b.getDate().getFullYear()) return -1;                 
        else if(a.getDate().getFullYear() == b.getDate().getFullYear() && a.getDate().getMonth() < b.getDate().getMonth()) return -1;      
        else if(a.getDate().getFullYear() == b.getDate().getFullYear() && a.getDate().getMonth() == b.getDate().getMonth() && a.getDate().getDate() < b.getDate().getDate()) return -1;
        else if(a.getDate().getFullYear() == b.getDate().getFullYear() && a.getDate().getMonth() == b.getDate().getMonth() && a.getDate().getDate() == b.getDate().getDate()) return 0;

        return 1;
    }

    /**
     * Sort from greatest to least
     * @param a 
     * @param b 
     * @return Int
     */
    public static function compareReverse(a : Post, b : Post) : Int
    {
        if(a.getDate().getFullYear() > b.getDate().getFullYear()) return -1;                 
        else if(a.getDate().getFullYear() == b.getDate().getFullYear() && a.getDate().getMonth() > b.getDate().getMonth()) return -1;      
        else if(a.getDate().getFullYear() == b.getDate().getFullYear() && a.getDate().getMonth() == b.getDate().getMonth() && a.getDate().getDate() > b.getDate().getDate()) return -1;
        else if(a.getDate().getFullYear() == b.getDate().getFullYear() && a.getDate().getMonth() == b.getDate().getMonth() && a.getDate().getDate() == b.getDate().getDate()) return 0;

        return 1;
    }

    /**
     * Sort based on the order value
     * @param a 
     * @param b 
     * @return Int
     */
    public static function compareOrder(a : Post, b : Post) : Int
    {
        if(a.getOrder() < b.getOrder()) return -1;                 
        else if(a.getOrder() > b.getOrder()) return 1;

        return 0;
    }

    /**
     * Prepare the body content for compilation
     * @param frontmatterContent 
     */
    private function _createBody(frontmatterContent : Array<String>)
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

            this._body = current;
        }
        else
        {
            this._body = frontmatterContent[2];
        }
    }
}