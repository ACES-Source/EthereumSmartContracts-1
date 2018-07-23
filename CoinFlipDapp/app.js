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

    // when the doc is loaded
    $(document).ready(function () {
        init(function () {
            // get the balance from the contract
            getBalance();
        });
    });
    // this is out smart contract
})(Contracts['CoinFlip']);