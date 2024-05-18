// SPDX-License-Identifier: GPT-3

pragma solidity >=0.8.2 <0.9.0;

contract MyWallet {

    // State variable

    address private owner;

    struct transaction {
        address sender;
        uint256 amount;
        uint256 time;
        string tx_type;

    }

    transaction[] public transactions;

    constructor () {

        // make contract deployer the owner

        owner = msg.sender;
    }


    function depositToken() public payable {
        require(msg.value > 0, "you cant send zero ETH");
        transactions.push(transaction(msg.sender, msg.value, block.timestamp, "Recieved"));
    }

    function checkBalance() public view returns(uint256) {
        require(msg.sender == owner, "You are not the wallet owner");
        return address(this).balance;
    }

    function sendToken(address to, uint amount) public {
        require(msg.sender == owner, "You are not the wallet owner");
        require(amount <= address(this).balance, "Insufficient Funds");
        payable(to).transfer(amount);
        transactions.push(transaction(address(this), amount, block.timestamp, "Sent"));
    }

    function withdrawToken(uint amount) public {
        require(msg.sender == owner, "You are not the wallet owner");
        require(amount <= address(this).balance, "Insufficient Funds");
        payable(owner).transfer(amount);
        transactions.push(transaction(address(this), amount, block.timestamp, "Withdrawn"));
    }
    function GetTrnxHistory() public view returns (transaction[] memory) {
        return transactions;
    }
}
