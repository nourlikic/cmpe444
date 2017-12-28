pragma solidity 0.4.16;

contract Splitter6{

	uint public denominator = 10**9;
	mapping(bytes32=>mapping(address=>uint)) shares;
	mapping(bytes32=>bool) inCirculation;

	event TXN(address indexed sender,address indexed receiver,bytes32 indexed doc,uint amount);

	function issue(bytes32 doc, address[] receivers, uint[] _shares){
		
		require(!inCirculation[doc]);
		require(receivers.length == _shares.length);
		uint totalShares = 0;
		for(uint i = 0; i<receivers.length; i++){
			totalShares += _shares[i];
		}
		require(totalShares == denominator);
		for(i = 0; i<receivers.length; i++){
			//require(shares[receivers[i]] == 0);
 			shares[doc][receivers[i]] = _shares[i];	
		}
		inCirculation[doc] = true;
		for(i = 0; i<receivers.length; i++){
			TXN(msg.sender,receivers[i],doc,_shares[i]);	
		}
	}

	function transfer(bytes32 doc, address[] receivers, uint[] _shares){

		require(inCirculation[doc]);
		require(receivers.length == _shares.length);
		
		uint sharesTransfered = 0;
		
		for(uint i = 0; i<receivers.length; i++){
			sharesTransfered += _shares[i];
		}

		require(shares[doc][msg.sender] >= sharesTransfered);

		shares[doc][msg.sender] = shares[doc][msg.sender] - sharesTransfered;

		for(i = 0; i<receivers.length; i++){
			shares[doc][receivers[i]] = shares[doc][receivers[i]] + _shares[i];
		}
		for(i = 0; i<receivers.length; i++){
			TXN(msg.sender,receivers[i],doc,_shares[i]);	
		}
	}

	function kill(bytes32 doc){

		require(inCirculation[doc]);
		require(shares[doc][msg.sender] == denominator);
		shares[doc][msg.sender] = 0;
		inCirculation[doc] = false;
	}

	function get(bytes32 doc, address addr) constant returns(uint){
		return shares[doc][addr];
	}
}
