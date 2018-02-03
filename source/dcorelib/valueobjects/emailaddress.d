module dcorelib.valueobjects.emailaddress;

import dcorelib.valueobjects.constrainedstring;
import std.string;
import std.stdio;

class EmailAddress : ConstrainedString
{
    this(string newValue, string identifier) @safe
    {
        // An email address must not exceed 254 characters in length.
        // https://stackoverflow.com/questions/386294/what-is-the-maximum-length-of-a-valid-email-address#574698
        super(newValue, 254, false, identifier);

        if (!this.empty()) {
            if (!this.emailAddressLooksValid(this.value)) {
                throw new Exception(format("%s does not appear to be a valid email address", identifier));
            }
        }
    }

    private bool emailAddressLooksValid(in ref string emailAddress) @safe
    {
        // Ensure there is at @ symbol and that the @ symbol is not the first character
        auto atPos = indexOf(emailAddress, "@");
        if (atPos <= 0) {
            return false;
        }

        // Ensure there is not a second @ symbol
        auto atPos2 = indexOf(emailAddress, "@", atPos + 1);
        if (atPos2 > 0) {
            return false;
        }

        // Ensure there is a dot after the the at symbol
        auto dotPos = indexOf(emailAddress, ".", atPos + 2);
        if (dotPos <= 0) {
            return false;
        }

        // Ensure the dotPost is not the last OR second last character
        if(dotPos >= emailAddress.length - 2) {
            return false;
        }

        return true;
    }     
}

unittest {
    /********************** UNIT TESTS THAT SHOULD FAIL ********************/
    try {
        auto email = new EmailAddress("aaaaaa.com", "email");
        assert(false, "Was able to create an Email address without an @ symbol");
    } catch(Exception e) {

    }

    try {
        auto email = new EmailAddress("aaaaaa@com", "email");
        assert(false, "Was able to create an Email address without a . symbol");
    } catch(Exception e) {

    }

    try {
        auto email = new EmailAddress("aaaaaa@hello.", "email");
        assert(false, "Was able to create an Email address with a . symbol in the wrong position");
    } catch(Exception e) {

    }

    try {
        auto email = new EmailAddress("aaaaaa@hello.c", "email");
        assert(false, "Was able to create an Email address with a domain suffix that is too short");
    } catch(Exception e) {

    }

    try {
        auto email = new EmailAddress("aaaaaa@hello@another.co", "email");
        assert(false, "Was able to create an Email address with a second @ symbol");
    } catch(Exception e) {

    }    

    /********************** UNIT TESTS THAT SHOULD PASS ********************/
    auto email1 = new EmailAddress("aaaaaa@hello.com", "email");
    assert(email1.toString() == "aaaaaa@hello.com");

    auto email2 = new EmailAddress("a@h.co", "email");
    assert(email2.toString() == "a@h.co");    
}