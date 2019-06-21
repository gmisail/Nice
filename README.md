![Logo](/NiceLogo.png)

## What is Nice?

Nice is a simple static site generator that makes it incredibly easy for developers to generate static webpages. 

## Installation

Nice is distributed through haxelib. To install, type into terminal:

`haxelib install nice`

Once you have Nice installed, you need to set up your website. To do so, create a new folder and populate it with the following files and folders:

> Pro tip:
> Instead of creating these folders, you can run the ```haxelib run nice create``` command and generate the folders automatically!

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

Posts are very easy to create; all you have to do is create a new file in the `_posts` folder with a HTML extension. You can do this manually or by using the command `haxelib run nice create-post PutYourPostNameHere`.

A normal post will look like this:

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

## Pages

Pages are very similar to posts, however they are not sorted chronologically.

To create a new page, all you have to do is create a new file in the `_pages` folder with a HTML extension. Much like posts, there are two ways to do this: manually or with the command line. Using the command line, you will need to run the `haxelib run nice create-page PutYourPageNameHere` command.

A normal page will look like this:

```
---
title: About Me
---

<p>
Let me tell you about myself...
</p>
```
