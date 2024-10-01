// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.27;

library LibDiamond {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.diamond.storage");

    struct Product {
        uint256 id;
        string name;
        uint256 price;
        uint256 quantity;
    }

    struct DiamondStorage {
        address owner;
        mapping(bytes4 => address) contractAdress;
        string name;
        string companyName;
        string studentame;
        //Market
        Product removeMe;
        mapping(uint256 => Product) products;
        Product[] productArray;
        bytes4 testSig;
    }

    function getStorage() internal pure returns (DiamondStorage storage s) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }
}
