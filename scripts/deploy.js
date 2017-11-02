function deploy(bin,abi){

var _contract = web3.eth.contract(abi);
var x = _contract.new(
   {
     from: web3.eth.accounts[0],
     data: bin,
     gas: '4700000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })
return x;
}

function watch(e,def){

  e.watch(function(error, result){
    if(!error)
      console.log(def)
      console.log(JSON.stringify(result))
  });
}

function contractFromAbi(abi,addr){

  return web3.eth.contract(abi).at(addr);
}