package nice.util;

class DateStamp
{
    public var year : String;
    public var month : String;
    public var day : String;

    public function new(value : Int)
    {
        var date = Std.string(value);
        year = date.substr(0, 4);
        month = date.substr(4, 2);
        day = date.substr(6, 2);
    }

    public function render()
    {
        return '${month}/${day}/${year}';
    }
}