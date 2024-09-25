// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.27;

import "../Libarary/LibDiamond.sol";

contract DiamondCut {
    struct Facet {
        address contractAddress;
        bytes4[] contractBytes;
    }

    function addFunctions(Facet[] memory _focetCut) public {
        for (uint256 facetIndex; facetIndex < _focetCut.length; facetIndex++) {
            address facetAdress = _focetCut[facetIndex].contractAddress;
            bytes4[] memory facetFunctions = _focetCut[facetIndex]
                .contractBytes;
            for (
                uint256 functionIndex;
                functionIndex < facetFunctions.length;
                functionIndex++
            ) {
                LibDiamond.getStorage().contractAdress[
                    facetFunctions[functionIndex]
                ] = facetAdress;
            }
        }
    }

    function removeFunction(bytes4 _functionData) public {
        LibDiamond.getStorage().contractAdress[_functionData] = address(0);
    }

    function setOwner(address _owner) public {
        LibDiamond.getStorage().owner = _owner;
    }
}
