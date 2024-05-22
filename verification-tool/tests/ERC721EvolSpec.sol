// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ERC721EvolSpec  {

    struct Counter {
        uint256 _value;
        uint256 _value01;  
    }


   // forall (address owner) _structOwnedTokensCount[owner]._value == _ownedTokensCount[owner]

    mapping (address => Counter) private _structOwnedTokensCount;

    /// @notice postcondition _structOwnedTokensCount[owner]._value == balance
    function balanceOf(address owner) public view returns (uint256 balance) {
    }

}