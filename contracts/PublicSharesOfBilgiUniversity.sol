pragma solidity 0.4.16;

/*
Rinkeby address
0x1bd60449f8e433af8fa9ce36347d090664f26720
*/
/*
ABI
[{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"vaultContract","type":"address"},{"name":"amount","type":"uint256"}],"name":"deposit","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"getBalanceOf","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"receiver","type":"address"},{"name":"amount","type":"uint256"}],"name":"transfer","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"name":"sender","type":"address"},{"indexed":true,"name":"receiver","type":"address"},{"indexed":true,"name":"amount","type":"uint256"}],"name":"TransferEvent","type":"event"}]
*/

import './Interface.sol';

contract PublicSharesOfBilgiUniversity is DepositableTokenContract{

	uint public totalSupply = 10**9;
	mapping(address => uint) balances;
	event TransferEvent(address indexed sender,address indexed receiver,uint indexed amount);

	function PublicSharesOfBilgiUniversity(){
		balances[msg.sender] = totalSupply;
	}

	/*
	me = eth.accounts[0]
	nameserver = eth.contract(ADDR).at(ABI)
	shares = eth.contract(ABI).at(ADDR)
	shares.getBalanceOf(me)
	... if bigger than 0
	shares.transfer(nameserver.owner(web3.sha3(selamicelik.bilgi)),AMOUNT)
	*/

	function transfer(address receiver,uint amount)
	public returns(bool){
		// Checks if balance is sufficient
		require(balances[msg.sender] >= amount);
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		TransferEvent(msg.sender,receiver,amount);
		return true;
	}

	function deposit(address vaultContract,uint amount)
	public returns(bool){
		// Checks if balance is sufficient
		require(balances[msg.sender] >= amount);
		DepositableVault vault = DepositableVault(vaultContract);
		if(vault.depositToken(msg.sender,amount)){
			balances[msg.sender] -= amount;
			balances[vaultContract] += amount; // Attention!
			//Receiver is a contract
		}
		return true;
	}

	function getBalanceOf(address addr)
	constant
	returns(uint){
		return balances[addr];
	}
}


