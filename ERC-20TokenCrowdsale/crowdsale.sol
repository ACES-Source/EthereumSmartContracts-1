pragma solidity ^0.4.16;

// this allows us to transfer tokens on the actual token contract
interface WadsToken {
    function transfer(address receiver, uint amount);
}

contract Crowdsale {

    // define all of the parts of the crowdsale contract
    address public beneficiary;
    uint public fundingGoal;
    uint public totalAmountRaised;
    uint public CrowdsaleDeadline;
    uint public tokenPrice;
    WadsToken public token;
    mapping(address = > uint) public balanceOf;
    bool fundingGoalReached = false;
    bool crowdsaleClosed = false;

    /**
     * Constructor
     * ifSuccessfulSendTo: Address where funds should be sent if sale reaches target
     * goalInEther: What is the target goal for the crowdsale in ethers.
     * durationInMinutes: How long will the crowdsale be running.
     * tokenPriceInEther: How much does each token cost
     * addressOfToken: Where is the token contract deployed.
     */
    function Crowdsale(
        address ifSuccessfulSendTo,
        uint goalInEther,
        uint durationInMinutes,
        uint tokenPriceInEther,
        address addressOfToken
    ) {

        // who gets the token?
        beneficiary = ifSuccessfulSendTo;

        // goal
        fundingGoal = goalInEther;

        // when will it end? from the time the contract
        // is created until the time we specify in minutes
        crowdSaleDeadline = now + durationInMinutes * 1 minutes;

        // token price
        tokenPrice = tokenPriceInEther * 1 ether;

        // which token will this crowdsale interact with?
        token = WadsToken("address");
    }

    /**
     * Fallback function
     *
     * Default function which gets called when someone sends money to the contract. Will be used for joining sale.
     */
    function () payable {
        // make sure the crowdsale is not closed
        require(!crowdsaleClosed);

        // add to the total raised
        uint amount = msg.value;

        // add more to their balance 
        balanceOf[msg.sender] += amount;

        // check the balance of the sender
        totalAmountRaised += amount;
        
        // transfer tokens from the token contract to the user
        // we use the interface to do this
        token.transfer(msg.sender, amount);
    }

    /**
     * Modifier used to check if deadline for crowdsale has passed
     */
    modifier afterDeadline() {

    }

    /**
     * Check if the funding goal was reached. Will only be checked if afterDeadline modifier above is true.
     *
     */
    function checkGoalReached() afterDeadline {

    }


    /**
     * Withdraw the funds
     *
     * Will withdraw the money after the deadline has been reached. If the goal was reached, only the owner can withdraw money to the beneficiary account.
     * If you goal was not reached, everyone who participated can withdraw their share.
     */
    function safeWithdrawal() afterDeadline {

    }
}