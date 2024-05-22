// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ERC721 {

    mapping (address => uint256) private _ownedTokensCount;

    function balanceOf(address owner) public view returns (uint256 balance) {
        require(owner != address(0));
        return _ownedTokensCount[owner];
    }

}