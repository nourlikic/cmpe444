pragma solidity 0.4.16;

contract CMPE444Token{

	uint public constant totalSupply = 10**9;
	mapping(address => uint) balances;

	function CMPE444Token(){
		balances[msg.sender] = totalSupply;
	}

	function transfer(address receiver,uint amount){
		// Check if balance is sufficient
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
