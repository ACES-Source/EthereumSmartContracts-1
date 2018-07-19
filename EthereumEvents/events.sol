pragma solidity ^0.4.0;


contract ClientReceipt {

    // setup an event to minitor
    // minitor 3 params from , tx_id , value
    event Deposit(
        address indexed _from,
        bytes32 indexed _id,
        uint _value
    );

    // deposit 
    // amount , tx id
    function deposit(bytes32 _id) {
        // Any call to this function (even deeply nested) can
        // be detected from the JavaScript API by filtering
        // for `Deposit` to be called.
        Deposit(msg.sender, _id, msg.value);
    }
}