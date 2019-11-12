package nice.fs;

import nice.cli.Output;
import sys.FileSystem;
import sys.io.File;

class Directory
{
    private var _local : String;
    private var _names : Array<String>;
    private var _contents : Map<String, String>;

    public function new(_local : String)
    {
        this._local = _local;

        if(!FileSystem.exists(this._local))
        {
            Output.error("Cannot find directory /" + this._local + ".");
            Sys.exit(1);
        }

        this._names = FileSystem.readDirectory(this._local);
        this._contents = _loadFiles(this._names);
    }

    /**
     * Create a new directory with a given name
     * @param name 
     */
    public static function create(name : String)
    {
        FileSystem.createDirectory(name);
    }

    /**
     * Checks to see if a directory exists or not
     * @param name 
     */
    public static function exists(name : String) : Bool
    {
        return FileSystem.exists(name);
    }

    /**
     * Returns the _contents of a file in the directory
     * @param name 
     * @return content
     */
    public function getFile(name : String) : String
    {
        return this._contents.get(name);
    }

    /**
     * Returns the local path of the directory
     * @return String
     */
    public function getLocalPath() : String
    {
        return this._local;
    }

    /**
     * Get the _names of each of the files in the directory
     */
    public function files()
    {
        return this._contents.keys();
    }

    /*
     * Load a list of files into memory
    */
    private function _loadFiles(files : Array<String>) : Map<String, String>
    {
        var file_contents = new Map();
        for(file in files)
        {
            if(FileSystem.isDirectory('$_local/$file'))
            {
                file_contents.set(file, "directory");
            }
            else
            {
                file_contents.set(file, File.getContent('$_local/$file'));
            }
        }

        return file_contents;
    }

}