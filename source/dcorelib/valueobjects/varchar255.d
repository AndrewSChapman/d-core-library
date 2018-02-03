module dcorelib.valueobjects.varchar255;

import dcorelib.valueobjects.constrainedstring;

class Varchar255 : ConstrainedString
{
    this(string newValue, string identifier) @safe
    {
        super(newValue, 255, false, identifier);
    }
}
