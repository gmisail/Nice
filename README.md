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

## Project Structure

A template for a Nice website is located in `/export`. Nice has a few requirements:

- `assets/` - static files that are copied over, e.g. images
- `layout/` - this is where your template file lives. Your template file must be called `index.html`
- `pages/` - this folder holds all of the pages. Pages are like posts without tags or a date.
- `pages/404.html` - 404 file
- `pages/home.html` - home page / page located at the root of your site. This file will be renamed to `index.html` and placed in the root.
- `posts/` - this folder holds all of the posts.
- `public/` - this folder is where Nice spits out your generated site
- `config.json` - config file for your Nice site. Configure site paths, site title, etc.
