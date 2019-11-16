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
    private static var _assets : Assets;
    private static var _posts : Collection;
    private static var _layouts : Layouts;
    private static var _pages : Collection;
    private static var _plugin_manager : PluginManager;
    private static var _plugins : Directory;

    private static var _config : ConfigFile;

    public static function process()
    {
        _config = new ConfigFile("config.yaml");

        _posts = new Collection(_config.getPostsPath(), _config.getSortPosts());
        _pages = new Collection(_config.getPagesPath(), _config.getSortPages());
        _layouts = new Layouts(_config.getLayoutsPath());
        _assets = new Assets(_config.getAssetsPath());

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
        clean(_config.getOutputPath());

        Directory.create(_config.getOutputPath());
        Directory.create(_config.getOutputPath() + "/_posts");
        Directory.create(_config.getOutputPath() + "/_assets");

        if(_config.getPlatform() == Platform.GITHUB_PAGES)
        {
            File.saveContent(_config.getOutputPath() + "/.nojekyll", "");
        }

        _assets.copy();

        _posts.render(_layouts, _posts, _pages, _config, _config.getOutputPath() + "/_posts", true);
        _pages.render(_layouts, _posts, _pages, _config, _config.getOutputPath(), false);
    }

    public static function clean(path : String)
    {
        if (FileSystem.exists(path) && FileSystem.isDirectory(path))
        {
            var entries = FileSystem.readDirectory(path);
            for (entry in entries)
            {
                if (FileSystem.isDirectory(path + '/' + entry))
                {
                    clean(path + '/' + entry);
                    FileSystem.deleteDirectory(path + '/' + entry);
                }
                else
                {
                    FileSystem.deleteFile(path + '/' + entry);
                }
            }
        }
    }
}