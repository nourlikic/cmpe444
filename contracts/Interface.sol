pragma solidity 0.4.16;


contract DepositableTokenContract{
	uint public totalSupply;
	mapping(address => uint) balances;
	function transfer(address receiver,uint amount) returns(bool);
	function getBalanceOf(address addr) constant returns(uint);
	function deposit(address vaultContract,uint amount) returns(bool);
}


contract DepositableVault{
	mapping(address=>mapping(address=>uint)) tokenBalances;
	function depositToken(address depositor,uint value) returns(bool);
	function getTokenBalance(address tokenContract,address addr) constant returns(uint);
}
