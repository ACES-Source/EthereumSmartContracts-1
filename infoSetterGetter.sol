// set the version of solidity you're using
pragma solidity ^0.4.0;

contract Info{
	
	// define and instantiate vars
	string name = "0";
	int age = 0;

	// NAME FUNCTIONS

	// setter
	// define the function and it's params
	function setName(string _input){
		// set the input param to name;
		name = _input;
	}

	// getter
	function getName() view returns (string){
		return name;
	}

	// AGE FUNCTIONS

	// setter
	function setAge(int _input){
		// set the input param to name;
		age = _input;
	}

	// getter
	function getAge() view returns (int){
		return age;
	}

}