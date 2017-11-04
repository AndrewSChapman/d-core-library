module dcorelib.valueobjects.varchar255required;

import dcorelib.valueobjects.constrainedstring;

import std.string;
import std.conv;
import std.stdio;

class Varchar255Required : ConstrainedString
{
    this(string newValue)
    {
        super(newValue, 255, true);
    }
}
