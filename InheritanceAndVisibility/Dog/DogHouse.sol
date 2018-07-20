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
	}


}