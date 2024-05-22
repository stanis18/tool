// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SimpleEvol {

    uint d;
    uint e;
    bool f;
    uint g;

    function set_a(uint _a) public {
        d = _a;
    }

    function set_b(uint _b) public {
        e = _b;
    }

    function set_c(bool _c) public {
        f = _c;
    }

    function set_g(uint _g) public {
        g = _g;
    }

    function get_selected() view public returns (uint resp) {
        if(!f) {
            return d;
        } else {
            return e;
        }
    }
}