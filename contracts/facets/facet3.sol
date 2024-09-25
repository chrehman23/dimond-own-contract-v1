// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.27;

import "../Libarary/LibDiamond.sol";

contract Company {
    function setComapnyName(string memory _companyName) public {
        LibDiamond.getStorage().companyName = _companyName;
    }

    function getComapnyName() public view returns (string memory) {
        return LibDiamond.getStorage().companyName;
    }
     function getOwner() public view returns (string memory) {
        return LibDiamond.getStorage().name;
    }
}
