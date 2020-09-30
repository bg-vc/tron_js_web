
function helloWord(value) {
       console.log(value);
}

function getTrxBalance(account) {
    console.log("getTrxBalance account:" + account);
    tronWeb.trx.getBalance(account).then(result => {
    console.log("getTrxBalance result:" + result);
    setTrxBalance(result);
    });
}

function sendTransaction(fromAccount, toAccount, amount) {
    console.log("sendTransaction fromAccount:" + fromAccount);
    console.log("sendTransaction toAccount:" + toAccount);
    console.log("sendTransaction amount:" + amount);
    var message = {from: fromAccount, to:toAccount, value: web3.toWei(amount, 'ether')};
    console.log("sendTransaction message:" + message.toString());
    web3.eth.sendTransaction(message, (err, res) => {
        if (err != null && !err) {
            console.log("sendTransaction error:" + err);
        } else {
            console.log("sendTransaction res:" + res);
        }
    })
}



