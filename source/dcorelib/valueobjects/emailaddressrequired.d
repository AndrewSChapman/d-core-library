module dcorelib.valueobjects.emailaddressrequired;

import dcorelib.valueobjects.emailaddress;
import std.string;

class EmailAddressRequired : EmailAddress
{
    this(string newValue, string identifier) @safe
    {
        super(newValue, identifier);

        if (this.empty()) {
            throw new Exception(format("%s must have a value", identifier));
        }
    }    
}

unittest {
    /********************** UNIT TESTS THAT SHOULD FAIL ********************/
    try {
        auto email = new EmailAddressRequired("", "email");
        assert(false, "Was able to create an EmailAddressRequired object without any value");
    } catch(Exception e) {

    }

    /********************** UNIT TESTS THAT SHOULD PASS ********************/
    auto email1 = new EmailAddressRequired("aaaaaa@hello.com", "email");
    assert(email1.toString() == "aaaaaa@hello.com");
}