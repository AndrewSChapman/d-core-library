module dcorelib.valueobjects.constrainedstring;

import std.string;

/**
Extend this class to make a read-only string that enforces a maximum length, and 
optionally whether a value must be provided.
**/
abstract class ConstrainedString
{
    protected string value;

    this(string newValue, in uint maxLength, bool valueRequired)
    {
        if (valueRequired && newValue.length == 0) {
            throw new Exception(format("%s must have a value", typeid(this)));
        }
        
        if (newValue.length > maxLength) {
            throw new Exception(
                format("%s must not have a length that is greater than %d characters", typeid(this), maxLength)
            );
        }

        this.value = newValue;
    }

    override public string toString()
    {
        return this.value;
    }

    public bool empty()
    {
        return this.value.length == 0;
    }

    public bool notEmpty()
    {
        return this.value.length > 0;
    }    
}

unittest {
    class VarChar10Required : ConstrainedString
    {
        this(string newValue)
        {
            super(newValue, 10, true);
        }
    }

    class VarChar10NotRequired : ConstrainedString
    {
        this(string newValue)
        {
            super(newValue, 10, false);
        }
    }

    /********************** UNIT TESTS THAT SHOULD FAIL ********************/
    try {
        auto name = new VarChar10Required("");
        assert(false, "Was able to create an required constrained string from a blank value");
    } catch(Exception e) {

    }  

    try {
        auto name = new VarChar10Required("Name Long!!");
        assert(false, "Was able to create a constrained string that is too long");
    } catch(Exception e) {

    }

    /********************** UNIT TESTS THAT SHOULD PASS ********************/
    auto name = new VarChar10Required("Bob Smith");
    assert(name.toString() == "Bob Smith");
    assert(name.notEmpty());
    assert(!name.empty());

    auto blank = new VarChar10NotRequired("");
    assert(blank.toString() == "");
    assert(blank.empty());
    assert(!blank.notEmpty());
}