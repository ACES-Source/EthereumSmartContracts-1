(function (Contract) {
    // web 3.0 will be overwritten so we need to create
    // a new web3 instance that won't be overwritten
    var web3_instance;
    var instance;
    // then create an accounts array
    var accounts;

    function init(cb) {
        web3_instance = new Web3(
            (window.web3 && window.web3.currentProvider) ||
            new Web3.providers.HttpProvider(Contract.endpoint));

        // now we can load the accounts from metamask
        accounts = web3.eth.accounts;

        // update all web3 calls to use the web3_instance
        var contract_interface = web3_instance.eth.contract(Contract.abi);
        instance = contract_interface.at(Contract.address);
        cb();
    }

    // get the balance from the smart contract
    function getBalance() {
        instance.getBalance(function (error, result) {
            if(error){
                alert(error);
            }
            else {
                // get value in HTML
                // 
                $('#balance').html(result.toString());
            }
        });
    }


    // check to see if the transaction was successfully
    // added to the blockchain
    function waitForReceipt(txHash, cb){
        // web3 eth function
        web3_instance.eth.getTransactionReceipt(txHash, function(error, receipt){
            if(error){
                alert(error);
            }
            // if we have a receipt do a callback
            // passing the receipt
            else if(receipt != null){
                cb(receipt);
            }
            // otherwise recursively check the blockchain
            // for a receipt every 5 seconds
            else{
                window.setTimeout(function(){
                    waitForReceipt(txHash, cb);
                }, 5000);
            }
        });
    }

    function flip(){
        // get the bet from the input box
        let val = parseInt($('#bet').val());

        /*
        sentTransaction
        Json - from, gas limit(wei), value(wei)
        */
                            // here we select the first account in metamask
        instance.flip.sendTransaction({from: "web3_instance.eth.accounts[0]",
                                      gas: 100000,
                                      value: val}, function(error, txHash){
            if(error){
                alert(error);
            }
            else{
                // poll the blockchain for a successful addition of the transaction
                waitForReceipt(txHash, function(receipt){
                    // if the status is equal to 1 in hex since it's a hash
                    if(receipt.status === "0x1"){
                        // alert the receipt (will always be in JSON)
                        alert(JSON.stringify(receipt));
                    }
                    // otherwise print an error 
                    else {
                        alert("Receipt status failed");
                    }
                });
            }
        });
    }

    // when the doc is loaded
    $(document).ready(function () {
        init(function () {
            // get the balance from the contract
            getBalance();
        });

        // when the button is clicked do a flip
        $('#submit').click(function(){
            flip();
        }); 

    });
    // this is out smart contract
})(Contracts['CoinFlip']);