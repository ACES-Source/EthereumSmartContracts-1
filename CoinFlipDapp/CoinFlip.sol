pragma solidity ^0.4.17;

contract CoinFlip {
    // define the owner
    address owner;

    // map the address (player) to a bool
    // this will be used to check if a user won or lost
    mapping(address => bool) lastFlip;
    
    // constructor
    // get the owner of the contract
    function CoinFlip() public {
        owner = msg.sender;
    }

    // get the balance of the contract
    function getBalance() constant public returns (uint){
        return this.balance;
    }


    // figure out who did the last flip
    // takes an argument (the player)
    // it will be a constant because its the players eth address
    // it's public so anyone can see it
    // returns true of false (won / lost)
    // return the mapping of the players address in lastFlip
    function getLastFlip(address player) constant public returns (bool){
    	return lastFlip[player];
    }


    // do a coinflip
    // we can't do randomness because all EVMs would get different results
    // this would cause a failure of concensus 
    // instead we rely on the timestamp and check
    // if it's divisible by 2
    // the bet is determined by the eth value the user sends
    // if the user wins then return the bet value + 100% of the bet
    function flip() payable public {
        uint time = block.timestamp;
        uint bet = msg.value;

        if(time % 2 == 0){
        	// this won't work unless we have some eth in the contract
            msg.sender.transfer(bet*2);
            // the player has won
            lastFlip[msg.sender] = true;
        }
        else{
        	// player lost
        	lastFlip[msg.sender] = false;
        }
    }


    // allow deposits of eth to the contract
    function deposit() payable public {

    }


}