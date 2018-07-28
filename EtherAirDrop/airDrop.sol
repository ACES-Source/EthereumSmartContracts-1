pragma solidity ^0.4.16;


interface WadsToken {
    function transferFrom(address from, address to, uint tokens);
}

contract Airdrop {
    
    // which token?
    WadsToken public token;
    // who holds the tokens then the contract is created
    address tokenHolder;
    // how many do we give out?
    uint amountToTransfer;
    
    

    function Airdrop(address addressOfToken, address addressOfHolder, uint fixedAmount){
        token = WadsToken(addressOfToken);
        tokenHolder = addressOfHolder;
        amountToTransfer = fixedAmount;
    }

    function drop() public {
    	// transfer the tokens from the holder to caller, some amount
    	token.transferFrom(tokenHolder, msg.sender, amountToTransfer); 
    }
}