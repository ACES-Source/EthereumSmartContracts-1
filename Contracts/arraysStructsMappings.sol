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

	// mapping to an ether address
	// => point 
	mapping(address => uint) ownerOfDog;

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
		//dogs.push(Dog(_dogName, _age));

		// map the address to the Dog
		// msg.sender is the address that called the contract
		address owner = msg.sender;

		// we need the ID of the dog
		// dogs.push returns the id
		uint id = dogs.push(Dog(_dogName, _age));

		ownerOfDog[owner] = id;
	}

	// getter function
	// returns an item from the array based on it's index
	function getDog() returns(string){

		// get the address of the person calling the function
		address owner = msg.sender;

		// get the dog that belongs to the msg.sender we can get it
		// from a hash since it will be the same as the previous hash
		// when the dog was added
		uint id = ownerOfDog[owner];

		// you can only return a single item
		// solidity arrays are 0 indexed so you have to subtract 
		// an index since dogs.push() was not 0 indexed
		return dogs[id-1].name;


	}
}
