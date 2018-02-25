module dcorelib.valueobjects.varchar500required;

import dcorelib.valueobjects.constrainedstring;

class Varchar500Required : ConstrainedString
{
    this(string newValue, string identifier) @safe
    {
        super(newValue, 500, true, identifier);
    }
}
