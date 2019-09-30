package nice.lib;

import sys.FileSystem;
import sys.io.File;

import nice.lib.core.Directory;

class Assets extends Directory
{
    private var subdirectories : Array<Directory>;

    public function new(path : String)
    {
        super(path);

        subdirectories = [];

        for(file in files())
        {
            if(FileSystem.isDirectory('${this.local}/$file'))
            {
                subdirectories.push(new Directory('${this.local}/$file'));
            }
        }
    }

    public function copy()
    {
        for(file in files())
        {
            if(!FileSystem.isDirectory('${this.local}/$file'))
            {
                File.copy('_assets/$file', '_public/_assets/$file');
            }
        }

        for(subdirectory in subdirectories)
        {
            Directory.create('${this.local}/${subdirectory.local}');
            for(subfile in subdirectory.files())
            {
                File.copy('${subdirectory.local}/$subfile', '${this.local}/${subdirectory.local}/$subfile');
            }
        }
    }

}