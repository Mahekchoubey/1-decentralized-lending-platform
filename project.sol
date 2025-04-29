// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedLendingPlatform {
    address public owner;
    mapping(address => uint) public balances;
    mapping(address => uint) public loans;

    constructor() {
        owner = msg.sender;
    }

    // Deposit funds into the platform (acts as lender)
    function deposit() external payable {
        require(msg.value > 0, "Must deposit more than 0");
        balances[msg.sender] += msg.value;
    }

    // Borrow funds from the platform
    function borrow(uint amount) external {
        require(amount > 0 && address(this).balance >= amount, "Invalid or insufficient funds");
        loans[msg.sender] += amount;
        payable(msg.sender).transfer(amount);
    }

    // Repay borrowed funds
    function repay() external payable {
        require(msg.value > 0 && loans[msg.sender] >= msg.value, "Invalid repay amount");
        loans[msg.sender] -= msg.value;
    }
}
