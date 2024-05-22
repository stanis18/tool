// SPDX-License-Identifier: MIT 
pragma solidity >=0.4.22 <0.9.0; 

contract Refinement0102 { 

    struct StateOld { 
        uint256 a; 
        uint256 b; 
        bool c; 
    } 

    struct StateNew { 
        uint256 d; 
        uint256 e; 
        bool f; 
        string g;
    } 

    StateOld od;
    StateOld od_old;
    StateNew nw;
    StateNew nw_old;



/** 
 * @notice precondition true 
 * @notice postcondition true */ 
function const_pre (uint _a, uint _b, bool _c, uint _d, uint _e, bool _f) public {} 

/** 
 * @notice precondition nw.d == od.a
 * @notice precondition nw.e == od.b
 * @notice precondition nw.f == od.c

 * @notice precondition od.a == _a
 * @notice precondition od.b == _b
 * @notice precondition od.c == _c


 * @notice precondition _d == _a
 * @notice precondition _e == _b
 * @notice precondition _f == _c

 * @notice postcondition nw.d == _d 
 * @notice postcondition nw.e == _e 
 * @notice postcondition nw.f == _f 
 */ 
function const_post (uint _a, uint _b, bool _c, uint _d, uint _e, bool _f) public {} 

// /** 
//  * @notice precondition true 
//  * @notice postcondition true */ 
// function set_f_pre () public {} 

// /** 
//  * teste 
//  */ 
// function set_f_post () public {} 

// /** 
//  * @notice precondition true 
//  * @notice postcondition true */ 
// function set_d_pre () public {} 

// /** 
//  * teste 
//  */ 
// function set_d_post () public {} 

// /** 
//  * @notice precondition true 
//  * @notice postcondition true */ 
// function get_selected_pre () public {} 

// /** 
//  * teste 
//  */ 
// function get_selected_post () public {} 

// /** 
//  * @notice precondition true 
//  * @notice postcondition true */ 
// function set_e_pre () public {} 

// /** 
//  * teste 
//  */ 
// function set_e_post () public {} 

}