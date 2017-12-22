/*
Rinkeby Address
0x4434b329406534715e984c5dcb11f4fb45be3957
*/

/*
ABI
[{"constant":false,"inputs":[{"name":"receiver","type":"address"},{"name":"value","type":"uint256"}],"name":"transferEther","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"tokenContractAddress","type":"address"},{"name":"receiver","type":"address"},{"name":"value","type":"uint256"}],"name":"sendToken","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"depositor","type":"address"},{"name":"value","type":"uint256"}],"name":"depositToken","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"depositEther","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[{"name":"receiver","type":"address"},{"name":"value","type":"uint256"}],"name":"sendEther","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"tokenContract","type":"address"},{"name":"addr","type":"address"}],"name":"getTokenBalance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"getEtherBalance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"tokenContract","type":"address"},{"name":"receiver","type":"address"},{"name":"value","type":"uint256"}],"name":"transferToken","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":true,"stateMutability":"payable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"tokenContract","type":"address"},{"indexed":false,"name":"depositor","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"TokenDeposit","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"tokenContract","type":"address"},{"indexed":false,"name":"sender","type":"address"},{"indexed":false,"name":"receiver","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"TokenTransfered","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"tokenContract","type":"address"},{"indexed":false,"name":"sender","type":"address"},{"indexed":false,"name":"receiver","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"TokenSent","type":"event"}]
*/

import "./Interface.sol";
pragma solidity 0.4.16;

contract Vault is DepositableVault{

	mapping(address=>uint) ethBalances;
	//TokenContract => OwnerAddress => Amount 
	mapping(address=>mapping(address=>uint)) tokenBalances;
	
	event TokenDeposit(address tokenContract,address depositor,uint value);
	event TokenTransfered(address tokenContract,address sender,address receiver,uint value);
	event TokenSent(address tokenContract,address sender,address receiver,uint value);

	function Vault() payable{

	}

	function depositEther() payable{
		ethBalances[msg.sender] = msg.value;
	}

	function transferEther(address receiver,uint value){
		require(ethBalances[msg.sender] >= value);
		ethBalances[msg.sender] -= value;
		ethBalances[receiver] += value;
	}

	function sendEther(address receiver,uint value){
		require(ethBalances[msg.sender] >= value);
		if(receiver.send(value)){
			ethBalances[msg.sender] -= value;
		}
	}

	function getEtherBalance(address addr) constant returns(uint){
		return ethBalances[addr];
	}

	// Only from token contract
	function depositToken(address depositor,uint value) returns(bool){
		tokenBalances[msg.sender][depositor] += value;
		TokenDeposit(msg.sender,depositor,value);
		return true;
	}

	function getTokenBalance(address tokenContract,address addr) constant returns(uint){
		return tokenBalances[tokenContract][addr];
	}

	function transferToken(address tokenContract,address receiver,uint value){
		require(tokenBalances[tokenContract][receiver] >= value);
		tokenBalances[tokenContract][msg.sender] -= value;
		tokenBalances[tokenContract][receiver] += value;
		TokenTransfered(tokenContract,msg.sender,receiver,value);
	}

	function sendToken(address tokenContractAddress,address receiver,uint value){
		require(tokenBalances[tokenContract][receiver] >= value);
		DepositableTokenContract tokenContract = DepositableTokenContract(tokenContractAddress);
		if(tokenContract.transfer(receiver,value)){
			tokenBalances[tokenContract][msg.sender] -= value;
		}
		TokenSent(tokenContract,msg.sender,receiver,value);
	}
}