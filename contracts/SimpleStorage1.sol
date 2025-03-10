// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract SimpleStorage {
    uint storeData;

    function set(uint x) public{
        storeData = x;
    }

    function get() public view returns (uint){
        return storeData;
    }
}