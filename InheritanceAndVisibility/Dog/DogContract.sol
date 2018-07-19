pragma solidity ^0.4.0;

contract DogContract {

	// create the Dog 
    struct Dog {
        string name;
        uint age;
    }

    // create an array of dogs
    Dog[] dogs;

    // maping array
    // maps address types to uints
   	// stores key/value pairs in ownerOfDog
    mapping(address => uint) ownerOfDog;

    // add a dog to the contract
    // requires name and age
    // visibility types
    // internal / external / public / private
    // internal: only the contract and it's inheritors can call this function
    // external: only external contracts can call this function
    // public: anyone can call this function
    // private: only this contract can call this function
    function addDog(string _name, uint _age) internal {
        // get the address of whoever initiated the contract
        address owner = msg.sender;
        // get the id of the dog or the index on the dogs array
        uint id = dogs.push(Dog(_name, _age));
        // map the id as the value for the owners key
        ownerOfDog[owner] = id;
    }

    // return the dog owned by the contract caller
    function getDog() returns (string) {
    	// get the owner
        address owner = msg.sender;
        // ge the id of the dog from the mapping
        uint id = ownerOfDog[owner];
        // return the dog -1 since the id is not 0 indexed
        // but the array is 0 indexed
        return dogs[id-1].name;
    }


}

