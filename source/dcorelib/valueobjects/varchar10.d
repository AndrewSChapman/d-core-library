module dcorelib.valueobjects.varchar10;

import dcorelib.valueobjects.constrainedstring;

class Varchar10 : ConstrainedString
{
    this(string newValue, string identifier) @safe
    {
        super(newValue, 10, false, identifier);
    }
}
