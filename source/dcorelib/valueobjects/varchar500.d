module dcorelib.valueobjects.varchar500;

import dcorelib.valueobjects.constrainedstring;

class Varchar500 : ConstrainedString
{
    this(string newValue, string identifier) @safe
    {
        super(newValue, 500, false, identifier);
    }
}
