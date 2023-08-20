// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
contract AccountPaymentSystem {
    address public owner;
    
    struct Account {
        uint id;
        uint balance;
        bool exists;
    }
    
    mapping(address => Account) private accounts;
   
    modifier onlyOwner() {
        require(owner == msg.sender, "only owner can make changes");
        _;
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    function addAccount(address _accountAddress, uint _accountId) public onlyOwner {
        
       Account storage account = accounts[_accountAddress];
        account.id = _accountId;
        account.balance = 0;
        account.exists = true;
    }
    
    function depositFunds(address _accountAddress, uint _amount) public onlyOwner returns(uint){
        Account storage account = accounts[_accountAddress];
        require(account.exists == true, "account does not exist");
        return account.balance += _amount;
    }
    
    function deductFunds(address _accountAddress, uint _amount) public onlyOwner returns(uint){
        Account storage account = accounts[_accountAddress];
        require(account.exists && account.balance >= 0, "Account does not exist or funds too low to deduct");
        return account.balance -= _amount;
    }
    
    function getBalance(address _accountAddress) public view returns (uint) {
        // Account storage account = accounts[_accountAddress];
        if(!accounts[_accountAddress].exists){
            return 0;
        }else return accounts[_accountAddress].balance;
    }
}