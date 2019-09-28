![Logo](/NiceLogo.png)

## What is Nice?

Nice is a simple static site generator that makes it easy for developers to generate static webpages. 

## Installation

Nice is distributed through haxelib. To install, type into terminal:

`haxelib install nice`

Once you have Nice installed, you need to set up your website. Nice makes it very easy to hit the ground running with a new project.

```
mkdir MyNewSite
cd MyNewSite
haxelib run Nice create project
haxelib run Nice build
```

First, you will create a new folder. Inside of this folder, you are going to create a new project and then build it. Easy, right? If you want to see your site in action, you can start a web server inside of the `_public` folder.

```
cd _public
python -m SimpleHTTPServer  # python 2
python3 -m http.server      # python 3
```

## Commands

Nice comes with a catalog of commands that make it incredibly easy to create, build, and manage your project.

```
haxelib run Nice build 
haxelib run Nice create <project/post/page/layout> <name>
haxelib run Nice delete <post/page/layout> <name>
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

Posts are very easy to create; all you have to do is create a new file in the `_posts` folder with a HTML extension. You can do this manually or by using the command `haxelib run nice create post PutYourPostNameHere`.

A normal post will look like this:

```
---
title: My Post Title!
date: 2001-01-23
---

<p>
Hello!
</p>
```

Dates follow the [YAML standard.](https://github.com/mikestead/hx-yaml)

## Pages

Pages are very similar to posts, however they are not sorted chronologically.

To create a new page, all you have to do is create a new file in the `bin._pages` folder with a HTML extension. Much like posts, there are two ways to do this: manually or with the command line. Using the command line, you will need to run the `haxelib run nice create page PutYourPageNameHere` command.

A normal page will look like this:

```
---
title: About Me
---

<p>
Let me tell you about myself...
</p>
```
