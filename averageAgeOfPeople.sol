pragma solidity ^0.4.0;

contract Peoples{

	// Define what is needed to make a person
	struct Person{
		string name;
		uint age;
	}

	// make an array of persons
	Person[] persons;


	function addPerson(string _name, uint _age){
		// push the Person to the persons array
		persons.push(Person(_name, _age));
	}

	function getAverageAge() view returns (uint) {

		// define a var to hold the sum of all ages
		uint total;

		// iterate through the array and get the ages
		// WARNING: Cannot use <= as it could go forever using infinite resources (buffer overflow)
		for (uint i=0; i < persons.length; i++){
			total += persons[i].age;
		}
        
        // return average
		return (total / persons.length);
	}
}