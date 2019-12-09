package nice.lib;

import sys.FileSystem;
import sys.io.File;

import nice.fs.Directory;

import nice.lib.*;
import nice.lib.util.Platform;
import nice.lib.util.ConfigFile;
import nice.lib.util.ItemType;
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

        _posts = new Collection(_config.getPostsPath(), _config.getSortPosts(), ItemType.POST);
        _pages = new Collection(_config.getPagesPath(), _config.getSortPages(), ItemType.PAGE);
        
        loadAssets();
        loadThemes();
        loadPlugins();
    }

    public static function compile()
    {
        var outputPath = _config.getOutputPath();

        Directory.clean(outputPath);
        Directory.create(outputPath);
        Directory.create(outputPath + "/_posts");
        Directory.create(outputPath + "/_assets");

        if(_config.getPlatform() == Platform.GITHUB_PAGES)
            File.saveContent(outputPath + "/.nojekyll", "");
    
        for(asset in _assets)
            asset.copy();

        _posts.render(_layouts, _posts, _pages, _config, outputPath + "/_posts", true);
        _pages.render(_layouts, _posts, _pages, _config, outputPath, false);
    }

    private static function loadAssets()
    {
        _assets = [];
        _assets.push(new Assets(_config.getAssetsPath()));
    }

    private static function loadThemes()
    {
        if(_config.getTheme() == "default")
        {
            _layouts = new Layouts(_config.getLayoutsPath());
        }

        if(FileSystem.exists("_themes"))
        {
            var theme = _config.getTheme();

            if(theme != "default")
            {
                _layouts = new Layouts(_config.getThemesPath() + "/" + theme + "/_layouts");
                _assets.push(new Assets(_config.getThemesPath() + "/" + theme + "/_assets"));
            }
        }
    }

    private static function loadPlugins()
    {
        if(FileSystem.exists("_plugins"))
        {
            _plugin_manager = new PluginManager(_config.getPluginsPath());
            _plugins = new Directory(_config.getPluginsPath());
            
            for(name in _plugins.files())
            {
                _plugin_manager.add(name);
            }

            _plugin_manager.execute(_posts.getItems(), _pages.getItems());
        }
    }
}