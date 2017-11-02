pragma solidity 0.4.16;
import "./Owned.sol";

contract Asset is Owned{


	function Asset(){

	}

	function transfer(address newOwner) 
	public
	onlyOwner{
		owner = newOwner;
	}

}
