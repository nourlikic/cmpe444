pragma solidity 0.4.16;

/*
Rinkeby address
0x4a641ccbb9b3c7eb5d32a3e31db3f41d77bcc241
*/
/*
ABI
[{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"getBalanceOf","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"receiver","type":"address"},{"name":"amount","type":"uint256"}],"name":"transfer","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]
*/

contract PublicSharesOfBilgiUniversity{

	uint public constant totalSupply = 10**9;
	mapping(address => uint) balances;

	function PublicSharesOfBilgiUniversity(){
		balances[msg.sender] = totalSupply;
	}

	function transfer(address receiver,uint amount)
	public{
		// Checks if balance is sufficient
		require(balances[msg.sender] >= amount);
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
	}

	function getBalanceOf(address addr)
	constant
	returns(uint){
		return balances[addr];
	}
}
