// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract SimpleStorage1_1 {
    uint storeData;

    function multiply(uint x) public view returns (uint){
        uint value = storeData*x;
        return value;
        
    }

        function set(uint x) public{
        storeData = multiply(x);
        
    }

    function get() public view returns (uint){
        return storeData;
    }
}



contract SimpleStorage1_2 {
    uint storeData;

    function multiply(uint a, uint b) public pure returns (uint){
        uint value = a * b;
        return value;
        
    }

        function set(uint x) public{
        storeData = multiply(storeData,x);
        
    }

    function get() public view returns (uint){
        return storeData;
    }
}




contract SimpleStorage5 {
    uint storeData;
   
    mapping (address => bool) public owner;


        function set(uint x) public{
        storeData = x;
        owner[msg.sender] = true;
        
    }

    function get() public view returns (uint){
        if (owner[msg.sender]) {
            return storeData;
        } else {
            return 0;
        }
    }
}

