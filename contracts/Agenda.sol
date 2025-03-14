// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;


contract Agenda1 {

    mapping (address => string) public agenda;

}

contract Agenda2 {

    mapping (address => string) public agenda;
    mapping (address => mapping (address => string)) public userAgenda;

    function createAgenda()public{
        require(bytes(agenda[msg.sender]).length == 0, "Agenda already created");
        agenda[msg.sender] = "";
    }


}

contract Agenda3 {

    mapping (address => string) public agenda;
    mapping (address => mapping (address => string)) public userAgenda;

    function createContact(address contact, string memory contactName)public{
       userAgenda[msg.sender][contact]= contactName;
    }
    function getContact(address contact) public view returns (string memory) {
        return userAgenda[msg.sender][contact];
    }
    function deleteContact(address contact) public {
        require(bytes(userAgenda[msg.sender][contact]).length != 0);
        delete userAgenda[msg.sender][contact];
    }

}
