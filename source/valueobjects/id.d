module dcorelib.valueobjects.id;

import std.string;
import std.conv;
import std.stdio;

class Id
{
    private string value;
    private ubyte colonPos;

    this(string newValue)
    {
        if ((newValue.length <= 10) || (newValue.length > 45)) {
            throw new Exception("An Id field may not have a length of less than 10 characters or greater than 45 characters");
        }

        this.colonPos = to!ubyte(newValue.indexOf(':'));

        if (this.colonPos < 1) {
            throw new Exception("An Id field must contain a : in the ID value");
        }

        value = newValue;
    }

    override public string toString()
    {
        return this.value;
    }

    public string getPrefix()
    {
        return this.value[0 .. this.colonPos];
    }
}

unittest {
    /********************** UNIT TESTS THAT SHOULD FAIL ********************/
    try {
        auto id = new Id("");
        assert(false, "Was able to create an Id from a blank value");
    } catch(Exception e) {

    }

    try {
        auto id = new Id("APPLE");
        assert(false, "Was able to create an Id from a value that was too short");
    } catch(Exception e) {

    }

    try {
        auto id = new Id("APPLEORANGEPEARBANANAAPPLEORANGEPEARBANANAAPPLEORANGEPEARBANANA");
        assert(false, "Was able to create an Id from a value that was too long");
    } catch(Exception e) {

    }

    try {
        auto id = new Id("APPLEORANGEPEARBANANAAPPLEORANGEPEAR");
        assert(false, "Was able to create an Id from a value that had no semi colon");
    } catch(Exception e) {

    }  

    /********************** UNIT TESTS THAT SHOULD PASS ********************/
    try {
        auto id = new Id("02DD6A2A:1509060290");
    } catch(Exception e) {
        assert(false, "Failed to create a valid Id");
    }

    auto id = new Id("02DD6A2A:1509060290");
    assert(id.toString() == "02DD6A2A:1509060290");
    assert(id.getPrefix() == "02DD6A2A");
}