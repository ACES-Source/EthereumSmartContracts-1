pragma solidity ^0.4.0;

// let users deposit, withdraw, and transfer eth and view their balance

contract BankContract{

	uint balance;
        address payable;

	function deposit() payable {
		balance += msg.value;
	}
        function withdraw() payable {
		balance -= msg.value;
	}
        function transfer() payable {
		balance -= msg.value;
	}
	function getBalance() view returns(uint){
		return balance;
	}
}
