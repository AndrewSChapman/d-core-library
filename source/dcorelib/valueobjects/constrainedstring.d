module dcorelib.valueobjects.constrainedstring;

import std.string;
import std.exception;

/**
Extend this class to make a read-only string that enforces a maximum length, and 
optionally whether a value must be provided.
**/
abstract class ConstrainedString
{
    protected string value;
    private string identifier;

    this(string newValue, in uint maxLength, bool valueRequired, string identifier) @safe
    {
        enforce(identifier != "", "Identifer for constrained string may not be empty");
        
        if (valueRequired && newValue.length == 0) {
            throw new Exception(format("%s must have a value", identifier));
        }
        
        if (newValue.length > maxLength) {
            throw new Exception(
                format("%s must not have a length that is greater than %d characters", identifier, maxLength)
            );
        }

        this.identifier = identifier;
        this.value = newValue;
    }

    override public string toString() @safe
    {
        return this.value;
    }

    public bool empty() @safe
    {
        return this.value.length == 0;
    }

    public bool notEmpty() @safe
    {
        return this.value.length > 0;
    }

    public string getIdentifier() @safe {
        return this.identifier;
    }
}

unittest {
    class VarChar10Required : ConstrainedString
    {
        this(string newValue, string identifier)
        {
            super(newValue, 10, true, identifier);
        }
    }

    class VarChar10NotRequired : ConstrainedString
    {
        this(string newValue, string identifer)
        {
            super(newValue, 10, false, identifer);
        }
    }

    /********************** UNIT TESTS THAT SHOULD FAIL ********************/
    try {
        auto name = new VarChar10Required("", "name");
        assert(false, "Was able to create an required constrained string from a blank value");
    } catch(Exception e) {

    }  

    try {
        auto name = new VarChar10Required("Name Long!!", "name");
        assert(false, "Was able to create a constrained string that is too long");
    } catch(Exception e) {

    }

    /********************** UNIT TESTS THAT SHOULD PASS ********************/
    auto name = new VarChar10Required("Bob Smith", "name");
    assert(name.toString() == "Bob Smith");
    assert(name.notEmpty());
    assert(!name.empty());
    assert(name.getIdentifier() == "name");

    auto blank = new VarChar10NotRequired("", "blank");
    assert(blank.toString() == "");
    assert(blank.empty());
    assert(!blank.notEmpty());
}