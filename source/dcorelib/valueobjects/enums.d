module dcorelib.enums;

enum Ternary { FALSE, TRUE, UNSPECIFIED }

unittest {
    Ternary t1 = Ternary.FALSE;
    Ternary t2 = Ternary.TRUE;
    Ternary t3 = Ternary.UNSPECIFIED;

    assert(!t1);
    assert(t2);
    assert(t3 == 2);
}