// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DeFiLending {

    mapping(address => uint256) public deposits;
    mapping(address => uint256) public borrows;

    uint256 public totalSupplied;
    uint256 public totalBorrowed;

    uint256 public baseRate = 2;      // 2%
    uint256 public multiplier = 10;   // 10%

    // Deposit ETH (Lending)
    function deposit() external payable {
        require(msg.value > 0, "Amount must be greater than zero");
        deposits[msg.sender] += msg.value;
        totalSupplied += msg.value;
    }

    // Withdraw ETH
    function withdraw(uint256 amount) external {
        require(deposits[msg.sender] >= amount, "Insufficient balance");
        deposits[msg.sender] -= amount;
        totalSupplied -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Borrow ETH (50% collateral rule)
    function borrow(uint256 amount) external {
        uint256 maxBorrow = deposits[msg.sender] / 2;
        require(amount <= maxBorrow, "Exceeds borrow limit");

        borrows[msg.sender] += amount;
        totalBorrowed += amount;
        payable(msg.sender).transfer(amount);
    }

    // Repay Loan
    function repay() external payable {
        require(borrows[msg.sender] > 0, "No active loan");
        require(msg.value <= borrows[msg.sender], "Excess repayment");

        borrows[msg.sender] -= msg.value;
        totalBorrowed -= msg.value;
    }

    // Dynamic Interest Rate Calculation
    function getInterestRate() public view returns (uint256) {
        if (totalSupplied == 0) return baseRate;
        uint256 utilization = (totalBorrowed * 100) / totalSupplied;
        return baseRate + (utilization * multiplier) / 100;
    }
}
