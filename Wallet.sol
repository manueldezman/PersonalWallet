//SPDX-License-Identifier: GPT-3

pragma solidity ^0.8.7;

contract  Wallet {
    address payable public owner;
    uint private contractBalance = address(this).balance;

    mapping (address => uint) public balances;

    uint private ownerBalance = balances[owner];

    constructor() {

        //make the contract creator the owner

        owner = payable(msg.sender);
    }

    function getBalance() public view returns(uint) {
       require(msg.sender == owner, "only owner can check Balance");
       return contractBalance;
   }

    function Send(address payable receiver, uint amount) public {
        require(msg.sender == owner, "only owner can Send");
        require(amount <= contractBalance, "Insuffient Funds");
        
        contractBalance -= amount;
        balances[receiver] += amount;
    }

    function Withdraw(uint amount) public {
        require(msg.sender == owner, "only owner can withdraw");
        require(amount <= contractBalance, "Insuffient Funds");

        contractBalance -= amount;
        ownerBalance += amount;
    }

    function FundWallet(uint amount) public {
        require(amount <= ownerBalance, "Insuffient Funds");

        balances[owner] -= amount; 
        contractBalance += amount;  
    }
}
