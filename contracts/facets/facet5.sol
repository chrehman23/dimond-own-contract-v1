// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.27;

import "../Libarary/LibDiamond.sol";

contract Products {
    modifier onlyOwner() {
        require(msg.sender == LibDiamond.getStorage().owner);
        _;
    }

    function setProduct(LibDiamond.Product calldata _product) public {
        LibDiamond.getStorage().products[_product.id] = _product;
        LibDiamond.getStorage().productArray.push(_product);
    }

    function setProducts(LibDiamond.Product[] calldata _products) public {
        for (
            uint256 productIndex;
            productIndex < _products.length;
            productIndex++
        ) {
            LibDiamond.getStorage().products[
                _products[productIndex].id
            ] = _products[productIndex];
            LibDiamond.getStorage().productArray.push(_products[productIndex]);
        }
    }

    function getProduct(
        uint256 _id
    ) public view returns (LibDiamond.Product memory) {
        require(
            LibDiamond.getStorage().products[_id].id != 0,
            "Product is not available"
        );
        LibDiamond.Product memory product = LibDiamond.getStorage().products[
            _id
        ];
        return product;
    }

    function getAllProducts()
        public
        view
        returns (LibDiamond.Product[] memory)
    {
        return LibDiamond.getStorage().productArray;
    }

    function getSig() public view returns (bytes4) {
        return LibDiamond.getStorage().testSig;
    }

    function getOWner() public view returns (address) {
        return LibDiamond.getStorage().owner;
    }

    function setOwner(address _address) public {
        LibDiamond.getStorage().owner = _address;
    }
}
