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

> Pro tip:
> Instead of running 'haxelib run Nice ...' copy the following code to `.bashrc` so you only have to run `nice`!

```
nice () {
    haxelib run Nice
}
```

## Theming

Nice does not come with a pre-installed theme or design. The user must design their own theme using HTML & Mustache.

You can use the following variables in your Mustache templates:

- title - Title of the current post / page.
- body - Body content (In your template, you MUST use triple braces ({{{body}}})! Without them, the page will not render properly)
- pages - Array of your site's pages.
- posts - Array of your site's posts.

### _layout/index.html Example

```
<html>
    <body>
        <h1>My cool blog!</h1>
        <h3>{{title}}</h3>
        <p>{{{body}}}</p>
        <hr>
        <h2>Other posts</h2>
        <ul>
    	    {{#posts}}
            	<li><a href="/_posts/{{name}}">{{title}}</a></li>
    	    {{/posts}}
        </ul>
    </body>
</html>
```
## Posts

Posts are very easy to create; all you have to do is create a new file in the `_posts` folder with a HTML extension. 

```
---
title: My Post Title!
date: 20000909
---

<p>
Hello!
</p>
```

Dates are formatted as: `YYYYMMDD`
