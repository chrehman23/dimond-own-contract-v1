// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.27;

import "../Libarary/LibDiamond.sol";

contract Student {
    function setStudentName(string memory _studentame) public {
        LibDiamond.getStorage().studentame = _studentame;
    }

    function getStudentName() public view returns (string memory) {
        return LibDiamond.getStorage().studentame;
    }

    function getSecondName() public view returns (string memory) {
        return LibDiamond.getStorage().studentame;
    }
}
