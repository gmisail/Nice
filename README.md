# Nice

## Installation

Nice is distributed through haxelib. To install, type into terminal:

`haxelib install nice`
 
 To generate your site, type:
 
 ```
 cd your-site-path
 haxelib run nice
 ```

## Theming

Nice does not come with a pre-installed theme or design. The user must design their own theme using HTML & the Haxe Templating language. 

The following variables are exposed from Nice to the templates:

- `::title::` - the title of the page / post
- `::body::` - the body text of the page / post
- `::posts::` - an array of the posts
- `::pages::` - an array of the pages
- `::name::` - name of the current file
- `::date::` - date of the current post
- `::tags::` - tags used by *all of the posts*. Duplicate tags are removed. 
- `::postTag::` - tags used by the *current post*. 

You can access these variables through the [Haxe Templating Engine](http://old.haxe.org/doc/cross/template). The template for every Nice page is located in `layout/index.html`.
