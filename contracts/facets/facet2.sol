// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.27;

import "../Libarary/LibDiamond.sol";

contract facet2 {
    function setContractOwner(address _address) public {
        LibDiamond.getStorage().owner = _address;
    }

    function getDimondOwner() public view returns (address) {
        return LibDiamond.getStorage().owner;
    }
}
