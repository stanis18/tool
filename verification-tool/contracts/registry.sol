pragma solidity >=0.5.0 <0.9.0;

contract Registry {
    address maintainer;
    mapping (address => string) verified_addrs;

    constructor() public {
        maintainer = msg.sender;
    }

    function new_mapping(address addr,  string memory spec_id) public {
        if (msg.sender == maintainer && bytes(spec_id).length == 0 ) {
            verified_addrs[addr] = spec_id;
        }
    }

    function get_spec(address addr) view public returns (string memory) {
        return verified_addrs[addr];
    }

}