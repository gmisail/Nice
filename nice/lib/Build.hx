package nice.lib;

import sys.FileSystem;
import sys.io.File;

import nice.fs.Directory;

import nice.lib.*;
import nice.lib.util.Platform;
import nice.lib.util.ConfigFile;
import nice.plugin.PluginManager;

class Build
{
    /**
     * Paths
     */
    private static var _assets : Array<Assets>;
    private static var _posts : Collection;
    private static var _layouts : Layouts;
    private static var _pages : Collection;

    /**
     * Plugins
     */
    private static var _plugin_manager : PluginManager;
    private static var _plugins : Directory;

    /**
     * Configuration
     */
    private static var _config : ConfigFile;

    public static function process()
    {
        _config = new ConfigFile("config.yaml");

        _posts = new Collection(_config.getPostsPath(), _config.getSortPosts());
        _pages = new Collection(_config.getPagesPath(), _config.getSortPages());
        
        _assets = [];
        _assets.push(new Assets(_config.getAssetsPath()));


        if(_config.getTheme() == "default")
        {
            _layouts = new Layouts(_config.getLayoutsPath());
        }

        if(FileSystem.exists("_themes"))
        {
            var theme = _config.getTheme();

            if(theme != "default")
            {
                _layouts = new Layouts("_themes/" + theme + "/_layouts");
                _assets.push(new Assets("_themes/" + theme + "/_assets"));
            }
        }

        if(FileSystem.exists("_plugins"))
        {
            _plugin_manager = new PluginManager("_plugins");
            _plugins = new Directory("_plugins");
            
            for(name in _plugins.files())
            {
                _plugin_manager.add(name);
            }

            _plugin_manager.execute(_posts.getItems(), _pages.getItems());
        }
    }

    public static function compile()
    {
        Directory.clean(_config.getOutputPath());
        Directory.create(_config.getOutputPath());
        Directory.create(_config.getOutputPath() + "/_posts");
        Directory.create(_config.getOutputPath() + "/_assets");

        if(_config.getPlatform() == Platform.GITHUB_PAGES)
            File.saveContent(_config.getOutputPath() + "/.nojekyll", "");
    
        for(asset in _assets)
        {
            asset.copy();
        }

        _posts.render(_layouts, _posts, _pages, _config, _config.getOutputPath() + "/_posts", true);
        _pages.render(_layouts, _posts, _pages, _config, _config.getOutputPath(), false);
    }
}