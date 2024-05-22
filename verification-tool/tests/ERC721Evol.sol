// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ERC721Evol  {

    struct Counter {
        uint256 _value; 
    }

    mapping (address => Counter) private _structOwnedTokensCount;

     
    function balanceOf(address owner) public view returns (uint256 balance) {
        require(owner != address(0));
        return _structOwnedTokensCount[owner]._value;
    }
}