// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract SimpleStorage1_1 {

        mapping (address => uint) public prePaidUsers;
            uint maxChargers;
            uint costPerMinute;

        constructor() public  {
            maxChargers = 25;
            costPerMinute = 25;
        }

        function prepaid(uint amount) payable external {
            uint timeInMinutes = amount/costPerMinute;
            
        }


}
