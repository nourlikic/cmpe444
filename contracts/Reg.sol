pragma solidity ^0.4.16;

/*
Rinkeby address
0xd245c4ef7c0335d2617987eebe671e04e6688936
*/

/*
[{"constant":true,"inputs":[{"name":"name","type":"bytes32"}],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"name","type":"bytes32"},{"name":"receiver","type":"address"}],"name":"transfer","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"name","type":"bytes32"}],"name":"register","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}]
*/

contract NameServer{

	// First-in owns
	mapping(bytes32=>address) nameStore;

	function register(bytes32 name){
		require(nameStore[name] == address(0));
		nameStore[name] = msg.sender;
	}

	function owner(bytes32 name) constant returns(address){
		return nameStore[name];
	}

	function transfer(bytes32 name, address receiver){
		require(nameStore[name] == address(0));
		nameStore[name] = receiver;
	}
}