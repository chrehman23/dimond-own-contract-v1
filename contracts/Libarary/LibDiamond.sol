// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.27;

library LibDiamond {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.diamond.storage");

    struct DiamondStorage {
        address owner;
        mapping(bytes4 => address) contractAdress;
        string name;
        string companyName;
        string studentame;
    }

    function getStorage() internal pure returns (DiamondStorage storage s) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }
}
