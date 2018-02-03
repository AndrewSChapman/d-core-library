module dcorelib.valueobjects.varchar255required;

import dcorelib.valueobjects.constrainedstring;

class Varchar255Required : ConstrainedString
{
    this(string newValue, string identifier) @safe
    {
        super(newValue, 255, true, identifier);
    }
}
