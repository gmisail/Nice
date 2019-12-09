package nice.lib;

import sys.FileSystem;
import sys.io.File;

import nice.filesystem.Directory;

class Assets extends Directory
{
    private var _subdirectories : Array<Directory>;

    public function new(path : String)
    {
        super(path);

        _subdirectories = [];

        for(file in files())
        {
            var subdirectoryPath = '${getLocalPath()}/$file';

            if(FileSystem.isDirectory(subdirectoryPath))
            {
                _subdirectories.push(new Directory(subdirectoryPath));
            }
        }
    }

    public function copy()
    {
        for(file in files())
        {
            if(!FileSystem.isDirectory('${getLocalPath()}/$file'))
            {
                var from = '${getLocalPath()}/$file';
                var to =  '_public/_assets/$file';

                File.copy(from, to);
            }
        }

        for(subdirectory in _subdirectories)
        {
            Directory.create('${getLocalPath()}/${subdirectory.getLocalPath()}');

            for(subfile in subdirectory.files())
            {
                var from = '${subdirectory.getLocalPath()}/$subfile';
                var to = '${getLocalPath()}/${subdirectory.getLocalPath()}/$subfile';

                File.copy(from, to);
            }
        }
    }

}