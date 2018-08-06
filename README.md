# Nice

## Installation

Nice is distributed through haxelib. To install, type into terminal:

`haxelib install nice`

Once you have Nice installed, you need to set up your website. To do so, create a new folder and populate it with the following files and folders:

- _assets/
- _layouts/
- _layouts/index.html
- _pages/
- _pages/index.html
- _posts/
- _public/

This is all you need to generate a Nice project!

To build your site, run this command:
 
 ```
 haxelib run nice build
 ```

Your site will output to the `_public` folder.

## Theming

Nice does not come with a pre-installed theme or design. The user must design their own theme using HTML & Mustache.

You can use the following variables in your Mustache templates:

- title - Title of the current post / page.
- body - Body content (In your template, you MUST use triple braces ({{{body}}})! Without them, the page will not render properly)
- pages - Array of your site's pages.
- posts - Array of your site's posts.

You can access these variables through the [Haxe Templating Engine](http://old.haxe.org/doc/cross/template). The template for every Nice page is located in `layout/index.html`.
