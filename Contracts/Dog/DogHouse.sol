pragma solidity ^0.4.0;

// import the file in the same directory
import './DogContract.sol';


// interface for the BankContract
// this has the functions from the BankContract
contract BankInterface{
	function getBalance() view returns(uint);
	function deposit() payable;
}


// inherit from DogContract
// is is the same as : in c++
contract DogHouse is DogContract {

	// function modifier
	// we can check if the call had enough gas to execute
	// this will add value to the contract
	// otherwise throw an error
	modifier costs(uint value){
		require(msg.value >= value);
		_; // this means continue to execute the function
	}


	// interface address for the BankContract that's already on the blockchain
	// then call the BankInterface in this file
	// set a variable as BankContract
	// assign it the interface from the address on the blockchain
	BankInterface = BankContract;

	function initBank(address _bankAddress) onlyOwner {
		BankContract = BankInterface(_bank);
	}


    // transfer requires the address of the new owner
    // make sure the call had 100 wei before executing
	function transferDog(address _newOwner) payable costs(100) {

	    // the msg.sender is the original owner 
		address owner = msg.sender;

		// make sure the _newOwner is not the same as the current ownerOfDog
		// sending the dog to ourselves would be pointless
		require(owner != _newOwner);

		// dogID is obtained from the ownerOfDog mapping
		uint dogID = ownerOfDog[owner];
		
		// delete old mapping
		delete(ownerOfDog[owner]);

		// set new mapping of the dog's ID to the new owner address
		ownerOfDog[_newOwner] = dogID;

		// make sure the transfer was successful - owner should no longer be
		// found in the ownerOfDog mapping
		// default value after deleting the mapping is 0
		assert(ownerOfDog[owner] == 0);


		// deposit the money in the bank
		BankContract.deposit.value(msg.value)();
	}

	// check how much money you have in the bank
	function getBankBalance() view returns (uint){
		return BankContract.getBalance();
	}

	// this will allow us to add a Dog from this contract
	// since the addDog function is internal
	function addDogHouseDog(string _name, uint _age){
		addDog(_name, _age);
	}

}