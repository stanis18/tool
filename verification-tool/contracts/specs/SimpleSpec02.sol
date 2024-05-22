// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

/// @notice  invariant d == d
contract SimpleSpec {

    uint d;
    uint e;
    bool f;
    string g;

    /// @notice postcondition d == _d
    /// @notice postcondition e == _e
    /// @notice postcondition f == _f
    constructor(uint _d, uint _e, bool _f) public {
    }

   
    /// @notice  postcondition f == _f
    function set_c(bool _f) public {
    }
    

    /// @notice postcondition d == _d
    function set_a(uint _d) public {
    }

    /// @notice postcondition resp == d || resp == e
    function get_selected() view public returns (uint resp) {
    }

    /// @notice postcondition e == _e
    function set_b(uint _e) public {
    }

    /// @notice postcondition g == _g
    function set_g(uint _g) public {
    }
    
}