// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ERC721Spec {

    mapping (address => uint256) private _ownedTokensCount;

    /// @notice postcondition _ownedTokensCount[owner] == balance
    function balanceOf(address owner) public view returns (uint256 balance) {
    }

}