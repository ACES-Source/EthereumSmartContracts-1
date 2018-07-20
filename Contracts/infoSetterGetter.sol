// set the version of solidity you're using
pragma solidity ^0.4.0;

contract Info{
	
	// define and instantiate vars
	string name = "0";
	uint age = 0;

	// NAME FUNCTIONS

	// setter
	// define the function and it's params
	function setName(string _inputName){
		// set the input param to name;
		name = _inputName;
	}

	// getter
	function getName() view returns (string){
		return name;
	}

	// AGE FUNCTIONS

	// setter
	function setAge(uint _inputAge){
		// set the input param to name;
		age = _inputAge;
	}

	// getter
	function getAge() view returns (uint){
		return age;
	}

}