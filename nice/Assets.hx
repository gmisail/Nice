package nice;

import sys.FileSystem;
import sys.io.File;

import nice.core.Directory;

class Assets extends Directory
{
    private var subdirectories : Array<Directory>;

    public function new()
    {
        super("_assets");

        subdirectories = [];

        for(file in files())
        {
            if(FileSystem.isDirectory('_assets/$file'))
            {
                subdirectories.push(new Directory('_assets/$file'));
            }
        }
    }

    public function copy()
    {
        for(file in files())
        {
            if(!FileSystem.isDirectory('_assets/$file'))
            {
                File.copy('_assets/$file', '_public/_assets/$file');
            }
        }

        for(subdirectory in subdirectories)
        {
            Directory.create('_public/${subdirectory.local}');
            for(subfile in subdirectory.files())
            {
                File.copy('${subdirectory.local}/$subfile', '_public/${subdirectory.local}/$subfile');
            }
        }
    }

}