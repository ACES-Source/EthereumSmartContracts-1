pragma solidity ^0.4.17;

contract CoinFlip {
    // define the owner
    address owner;
    
    // constructor
    // get the owner of the contract
    function CoinFlip() public {
        owner = msg.sender;
    }

    // get the balance of the contract
    function getBalance() constant public returns (uint){
        return this.balance;
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
            msg.sender.transfer(bet*2);
        }
    }

}