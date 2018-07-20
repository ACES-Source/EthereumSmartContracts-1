pragma solidity ^0.4.0;

import './Ownable.sol';

contract DogContract is Ownable {

    // create the Dog 
    struct Dog {
        string name;
        uint age;
    }

    // create an array of Dogs called dogs
    Dog[] dogs;

    // maping array
    // maps address types to uints
    // stores key/value pairs in ownerOfDog
    // this way we can see who owns the dog
    mapping(address => uint) ownerOfDog;


    // event to log when a dog is added
    event addedDog(address owner, string name, uint dogID);

    // add a dog to the contract
    // requires name and age
    function addDog(string _name, uint _age) internal {
        // get the address of whoever initiated the contract
        address owner = msg.sender;
        // get the id of the dog or the index on the dogs array
        // the ID is returned when we push the Dog into the dogs array
        uint id = dogs.push(Dog(_name, _age));
        // map the dogs id to the owner's ether address
        ownerOfDog[owner] = id;

        // log this event
        addedDog(owner, _name, id);
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

