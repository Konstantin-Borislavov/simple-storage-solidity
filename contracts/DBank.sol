// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract DBnank {
    mapping (address => uint) public clients;
    mapping (address => uint) public debtors;
    uint256 bankBlance;

    constructor() payable {
    }

    //Basic

    function deposit ()payable external {
        uint256 amount = msg.value;
        clients[msg.sender] += amount;
        bankBlance += amount;
    }
    ///Para evitar una situacion de corralito, si el dinero que hay en el banco llega a menos del 10%
    ///del total depositado por lis clientes, estos solo podran retirar la cantidad resultante de restar
    ///sus deudas a su dinero depositado
    function withdraw (uint256 amount) external {
        address payable client = payable(msg.sender);
        if(address(this).balance>((bankBlance * 10) / 100)){
            if(clients[client]>=amount){
            client.transfer(amount);
            clients[msg.sender] -= amount;
            }
        }else{
            require(amount< clients[client]-debtors[client],'Solo puedes sacar la diferencia entra tus deudas y tu saldo');
        }

    }

    function loan (uint256 amount) external {
        address payable client = payable(msg.sender);
        ///Coeficiente de caja del 5%
        if((address(this).balance>=amount)&&(address(this).balance>((bankBlance * 5) / 100))){
            client.transfer(amount);
            debtors[msg.sender] += amount;
        }
    }


    function checkBalance ()view public returns(uint){
        return clients[msg.sender];
    }

    function checkDebt ()view public returns(uint){
        return debtors[msg.sender];
    }

   


}
