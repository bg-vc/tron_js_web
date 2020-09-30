
function helloWord(value) {
       console.log(value);
}

function getTrxBalance(account) {
    console.log("getTrxBalance account: " + account);
    tronWeb.trx.getBalance(account).then(result => {
    console.log("getTrxBalance result: " + result);
    setTrxBalance(result);
    });
}

function sendTrx(toAccount, amount) {
    console.log("sendTrx toAccount: " + toAccount);
    console.log("sendTrx amount: " + amount);
    tronWeb.trx.sendTransaction(toAccount, amount).then(result => {
        console.log("sendTrx result: " + JSON.stringify(result));
        });
}

async function contractBalanceOf(account) {
    console.log("contractBalanceOf: " + account);
    var contractAddress = "4174472E7D35395A6B5ADD427EECB7F4B62AD2B071";
    let obj = await tronWeb.contract().at(contractAddress);
    let result = await obj.balanceOf(account).call();
    console.log('contractBalanceOf result: ' + result);
    setTokenBalance(result);
 }


async function contractTransfer(toAccount, amount) {
    console.log("contractTransfer toAccount:" + toAccount);
    console.log("contractTransfer amount:" + amount);
    var contractAddress = "4174472E7D35395A6B5ADD427EECB7F4B62AD2B071";
    let obj = await tronWeb.contract().at(contractAddress);

    let result = await obj.transfer(toAccount, amount).send({feeLimit:10000000});
    console.log("contractTransfer result:" + result);

    var myEvent = obj.Transfer();
    myEvent.watch(function(err, result) {
         console.log("contractTransfer event");
        if (!err) {
            console.log("contractTransfer event result:" + JSON.stringify(result));
             reloadContractBalanceOf();
             console.log("contractTransfer event end");
        } else {
            console.log("contractTransfer event error:" + JSON.stringify(err));
        }
        //myEvent.stopWatching();
    });



}



