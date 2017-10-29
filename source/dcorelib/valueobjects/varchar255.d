module dcorelib.valueobjects.varchar255;

import dcorelib.valueobjects.constrainedstring;

import std.string;
import std.conv;
import std.stdio;

class Varchar255 : ConstrainedString
{
    this(string newValue)
    {
        super(newValue, 255, false);
    }
}
