module dcorelib.valueobjects.varchar10required;

import dcorelib.valueobjects.constrainedstring;

class Varchar10Required : ConstrainedString
{
    this(string newValue, string identifier) @safe
    {
        super(newValue, 10, true, identifier);
    }
}
