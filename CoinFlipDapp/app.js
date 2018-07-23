(function (Contract) {
    var web3;
    var instance;

    function init(cb) {
        web3 = new Web3(
            (window.web3 && window.web3.currentProvider) ||
            new Web3.providers.HttpProvider(Contract.endpoint));

        var contract_interface = web3.eth.contract(Contract.abi);
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
        web3.eth.getTransactionReceipt(txHash, function(error, receipt){
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
                } 5000);
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
        instance.flip.sendTransaction({from: "0xa48f2e0be8ab5a04a5eb1f86ead1923f03a207fd",
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