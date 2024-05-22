// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract ProxyDiamond {

    function getFacet() internal view returns(address _facet) {
        bytes32 position = keccak256("facet");
        assembly {
        _facet := sload(position)
        }
    }

    function setFacet(address _facet) internal {
        bytes32 position = keccak256("facet");
        assembly {
        sstore(position, _facet)
        }
    }

    function getTrustedDeployer() internal view returns(address _trusted_deployer) {
        bytes32 position = keccak256("trusted_deployer");
        assembly {
            _trusted_deployer := sload(position)
        }
    }

    function setTrustedDeployer(address _trusted_deployer) internal {
        bytes32 position = keccak256("trusted_deployer");
        assembly {
        sstore(position, _trusted_deployer)
        }
    }

    constructor(address _facet, address _trusted_deployer, address _constructor) public {
        setFacet(_facet);
        setTrustedDeployer(_trusted_deployer);
        _constructor.delegatecall(abi.encodeWithSignature("cons()"));
    }


    event Fallback();

    function update(address _facet) public {
        require(msg.sender == getTrustedDeployer());
        setFacet(_facet);
    }

    fallback() external  {

    address _facet = getFacet();

    emit Fallback();

    // Execute external function from facet using delegatecall and return any value.
    assembly {
        // copy function selector and any arguments
        calldatacopy(0, 0, calldatasize())
        // execute function call using the facet
        let result := delegatecall(gas(), _facet, 0, calldatasize(), 0, 0)
        // get any return value
        returndatacopy(0, 0, returndatasize())
        // return any return value or error back to the caller
        switch result
        case 0 {revert(0, returndatasize())}
        default {return (0, returndatasize())}
        }
    }

}