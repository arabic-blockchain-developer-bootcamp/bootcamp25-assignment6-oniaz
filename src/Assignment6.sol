// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Assignment6 {
    // 1. Declare an event called `FundsDeposited` with parameters: `sender` and `amount`
    event FundsDeposited(address sender, uint amount);
    // 2. Declare an event called `FundsWithdrawn` with parameters: `receiver` and `amount`
    event FundsWithdrawn(address receiver, uint amount);
    // 3. Create a public mapping called `balances` to tracker users balances
    mapping(address => uint) public balances;
    // Modifier to check if sender has enough balance
    modifier hasEnoughBalance(uint amount) {
        // Fill in the logic using require
        require(balances[msg.sender] >= amount, "Insufficient balance");
        _;
    }

    // Function to deposit Ether
    // This function should:
    // - Be external and payable
    // - Emit the `FundsDeposited` event
    function deposit() external payable{
        // increment user balance in balances mapping 
        balances[msg.sender] += msg.value;
        // emit suitable event
        emit FundsDeposited(msg.sender, msg.value);

    }

    // Function to withdraw Ether
    // This function should:
    // - Be external
    // - Take one parameter: `amount`
    // - Use the `hasEnoughBalance` modifier
    // - Emit the `FundsWithdrawn` event
    function withdraw(uint amount) external hasEnoughBalance(amount) {
        // decrement user balance from balances mapping 
        balances[msg.sender] -= amount;
        // send tokens to the caller
        payable(msg.sender).transfer(amount);
        // emit suitable event
        emit FundsWithdrawn(msg.sender, amount);
    }

    // Function to check the contract balance
    // This function should:
    // - Be public and view
    // - Return the contract's balance
    function getContractBalance() public view returns (uint) {
        // return the balance of the contract
        return address(this).balance;
    }
}
