// define the version of solidity you're using
pragma solidity ^0.4.0;

// define the contract
contract Dog{
    
    // define variable
    // must include the variable type like C++
    string output = "Let's program on ethereum!";
    
    // positive or negative
    int number = 1;
    
    // define a function and it's return type
    function bark() returns (string) {
        // do something
        return "bark bark";
    }
    
    // getter
    // gets the value of output and returns it
    // the view keyword makes sure this can only get the value or view it
    function program() view returns (string){
        return output;
    }
    
    // setter
    // set the value of output
    // _ is a referense to self
    function setOutput(string _output){
        output = _output;
    }   
}