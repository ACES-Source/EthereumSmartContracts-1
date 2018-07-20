pragma solidity ^0.4.0;

// let users deposit eth and view their balance

contract BankContract{

	uint balance;

	function deposit() payable {
		balance += msg.value;
	}

	function getBalance() view returns(uint){
		return balance;
	}
}