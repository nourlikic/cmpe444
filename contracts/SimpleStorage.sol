pragma solidity 0.4.18;

contract SimpleStorage{

    uint value;
    address creator;

    function SimpleStorage(){
         // default value is 1000
         value = 1000;
         creator = msg.sender;
	}

    function setValue(uint _value){
         value = _value;
    }

    function getValue() constant returns(uint){
         return value;
    }

    function getCreator() constant returns(address){
         return creator;
    }
}