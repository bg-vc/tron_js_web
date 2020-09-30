
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



