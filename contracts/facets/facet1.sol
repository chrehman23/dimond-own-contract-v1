// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.27;

import "../Libarary/LibDiamond.sol";

contract facet1 {
    event OwnerNameUpdate(string name);

    function setOwner(string memory _name) public {
        LibDiamond.getStorage().name = _name;
        emit OwnerNameUpdate(_name);
    }

    function getOwner() public view returns (string memory) {
        return LibDiamond.getStorage().name;
    }
}
