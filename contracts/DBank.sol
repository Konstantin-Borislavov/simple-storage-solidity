// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract DBnank {
    address payable owner;
    mapping (address => uint) public clients;
    mapping (address => uint) public borrowers;
    mapping (address => uint) public loanTimestamp;
    mapping (address => uint) public loanDeadline;
    mapping (address => bool) public debtors;
    uint256 bankBalance;
    uint24 intrtestType;
    uint24 debtorIntrtestType;
    uint256 loanTerm = 365 days;
    

    //Cantidad pregargada al crear el comtrato.
    constructor() payable {
        owner = payable(msg.sender);
        bankBalance = msg.value;
        intrtestType = 3; 
        debtorIntrtestType = 10;
    }

    //Basic

    function deposit ()payable external {
        uint256 amount = msg.value;
        clients[msg.sender] += amount;
        bankBalance += amount;
    }
    ///Para evitar una situacion de corralito, si el dinero que hay en el banco llega a menos del 10%
    ///del total depositado por los clientes, estos solo podran retirar la cantidad resultante de restar
    ///sus deudas a su dinero depositado.
    function withdraw (uint256 amount) external {
        address payable client = payable(msg.sender);
        if(address(this).balance>((bankBalance * 10) / 100)){
            if(clients[client]>=amount){
            clients[msg.sender] -= amount;
            client.transfer(amount);
            }
        }else{
            require(amount<= clients[client]-borrowers[client],'Solo puedes sacar la diferencia entra tus deudas y tu saldo');
        }

    }

    function loan (uint256 amount) external {
        address payable client = payable(msg.sender);
        ///Coeficiente de caja del 5%
        if((address(this).balance>=amount)&&(address(this).balance>((bankBalance * 5) / 100))){
            borrowers[msg.sender] += amount;
            loanTimestamp[msg.sender] = block.timestamp;
            loanDeadline[msg.sender] = block.timestamp + 365 days;
            client.transfer(amount);
        }
    }

    function addDebtor(address client) public {
        if(block.timestamp > loanDeadline[client]){
            debtors[client] = true;
        }
    }

    function payDebt () external payable{
        address client = msg.sender;
        uint256 clientDebt = checkDebt();

        require(msg.value >= clientDebt, "Saldo insuficiente para pagar la deuda");
        borrowers[client] = 0;
        debtors[client] = false;
        loanTimestamp[client] = 0;
        loanDeadline[client] = 0;
        owner.transfer(clientDebt);

    }


    function checkBalance ()view public returns(uint){
        return clients[msg.sender];
    }

    function checkDebt ()view public returns(uint){
        address client = msg.sender;

        if (borrowers[client]>0 && debtors[client]==false){
            uint256 debtTime = block.timestamp - loanTimestamp[client];
            uint256 debtDays = debtTime / 365 days;
            uint256 intrest = (borrowers[client] * intrtestType * debtDays) / 100;
            return borrowers[client]+ intrest;
        }

        if (borrowers[client]>0 && debtors[client]==true){
            uint256 debtTime = block.timestamp - loanTimestamp[client];
            uint256 debtDays = debtTime / 365 days;
            uint256 intrest = (borrowers[client] * debtorIntrtestType * debtDays) / 100;
            return borrowers[client]+ intrest;
        }
        


    }

   


}
