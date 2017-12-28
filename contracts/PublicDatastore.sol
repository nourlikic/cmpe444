pragma solidity ^0.4.0;
/*
Rinkeby address
0x13de6fc45b1015003c2bd948fb03942b6d144ab5
*/

/*
ABI
[{"constant":false,"inputs":[{"name":"key","type":"bytes32"},{"name":"value","type":"bytes32"}],"name":"setValue","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"},{"name":"key","type":"bytes32"}],"name":"getValue","outputs":[{"name":"","type":"bytes32"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"name":"sender","type":"address"},{"indexed":true,"name":"key","type":"bytes32"}],"name":"ValueSet","type":"event"}]
*/

contract PublicDatastore {
	
	//address msg.sender
	//bytes32 key
	//bytes32 value
	mapping(address=>mapping(bytes32=>bytes32)) datastore;

	/*
	Filtering events
	> datastore = eth.contract(ABI).at(ADDR)
	> eventTopic = web3.sha3(address,bytes32)
	> filter = eth.filter({fromBlock:0,toBlock:'latest',address:datastore.address,topics:[eventTopic]}) 
	> filter.get()
	*/
	event ValueSet(address indexed sender, bytes32 indexed key);

	function setValue(bytes32 key,bytes32 value){
		datastore[msg.sender][key] = value;
		ValueSet(msg.sender,key);
	}

	function getValue(address addr,bytes32 key) constant returns(bytes32){
		return  datastore[addr][key];
	}
}