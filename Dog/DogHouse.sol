pragma solidity ^0.4.0;

// import the file in the same directory
import './DogContract.sol';

// inherit from DogContract
// is is the same as : in c++
contract DogHouse is DogContract {

    // transfer requires the address of the new owner
	function transferDog(address _newOwner){
	    // the msg.sender is the original owner 
		address owner = msg.sender;

		// make sure the _newOwner is not the same as the current ownerToDog
		require(owner != _newOwner)

		// dogID is obtained from the ownerToDog mapping
		uint dogID = ownerOfDog[owner];
		// delete old mapping
		delete(ownerOfDog[owner]);
		// set new mapping of the dog's ID to the new owner address
		ownerOfDog[_newOwner] = dogID;
	}


}