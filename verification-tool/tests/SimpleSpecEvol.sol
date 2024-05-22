// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 < 0.9.0;

/// @notice  invariant d == d
contract SimpleSpec {

    uint d;
    uint e;
    bool f;
    uint g;

    /// @notice  postcondition f == _c
    function set_c(bool _c) public {
    }
    

    /// @notice postcondition d == _a
    function set_a(uint _a) public {
    }

    /// @notice postcondition resp == d || resp == e
    function get_selected() view public returns (uint resp) {
    }

    /// @notice postcondition e == _b
    function set_b(uint _b) public {
    }

    /// @notice postcondition g == _g
    function set_g(uint _g) public {
    }
    
}