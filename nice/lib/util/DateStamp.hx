package nice.lib.util;

/*
*   Reimplement this, for the love of heck.
*/

class DateStamp
{
    public var year : String;
    public var month : String;
    public var day : String;
    public var actual : Bool = false;

    public function new(value : Int, ?actual : Bool = true)
    {
        this.actual = actual;

        var date = Std.string(value);
        this.year = date.substr(0, 4);
        this.month = date.substr(4, 2);
        this.day = date.substr(6, 2);
    }

    public function render()
    {
        if(actual)
            return '${month} / ${day} / ${year}';
        else 
            return '';
    }
}