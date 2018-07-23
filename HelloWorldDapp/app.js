
// Create a connection to a smart contract
(function (Contract) {
    var web3;
    var instance;

    // connect
    function init(cb) {
        web3 = new Web3(
            (window.web3 && window.web3.currentProvider) ||
            new Web3.providers.HttpProvider(Contract.endpoint));

        var contract_interface = web3.eth.contract(Contract.abi);
        instance = contract_interface.at(Contract.address);
        cb();
    }

    // get the current value from the blockchain
    function getMessage(cb) {
        instance.message(function (error, result) {
            cb(error, result);
        });
    }


    // update the value on the blockchain with whatever is in the text box when the 
    // update message button is clicked
    function updateMessage(){
        // get the value of the input box
        let newMessage = $('#message-input').val();
        // if there is a value..
        if(newMessage && newMessage.length > 0){
            // create a transaction to the blockchain from the contract creator address
            instance.update.sendTransaction(newMessage, {from: "0xa48f2e0be8ab5a04a5eb1f86ead1923f03a207fd", gas: 30000000}, function(error, result){
                // if it fails
                if(error){
                    alert("Error in sendtransaction");
                }
                // if it succeeds 
                else{
                    // create a timeout to check the value on the blockchain
                    setTimeout(function(){
                        getMessage(function (error, result) {
                        // if there's a problem getting the new value from the blockchain..
                        if (error) {
                            console.error("Could not get article:", error);
                            return;
                        }
                        // if it's successful then update the value of #message with the result
                        $('#message').html(result);
                        });
                    // timeout in 1k miliseconds
                    }, 1000);
                }
            });
        }
        else{
            alert("newMessage is not defined");
        }
    }

    // when everything is ready
    $(document).ready(function () {
        init(function () {
            // get the message
            getMessage(function (error, result) {
                if (error) {
                    console.error("Could not get article:", error);
                    return;
                }
                $('#message').append(result);
            });
        });
        // when the submit button is clicked
        // send a transaction and update the message
        $('#submitButton').click(function(){
            updateMessage();
        });
    });
})(Contracts['HelloWorld']);