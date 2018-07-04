// define the version of solidity
pragma solidity ^0.4.0;

contract DogContract{

	// define a struct
	struct Dog{
		string name;
		uint age;
	}

	// define an array	
	Dog[] dogs;

	// setter
	// adds an item to the array
	function addDog(string _dogName, uint _age){
		// push dogName to dogs array
		//dogs.push(_dogName);
	
		// with 2 variables we can create a new Dog struct
		// longhand version
		//Dog newDog = {_dogName, _age};

		// put the newDog in the array/list
		// short hand version
		dogs.push(Dog(_dogName, _age));
	}

	// getter function
	// returns an item from the array based on it's index
	function getDog(uint _id) returns(string){
		// you can only return a single item
		return dogs[_id].name;
	}
}
