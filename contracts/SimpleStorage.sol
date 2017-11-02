pragma solidity 0.4.18;

contract SimpleStorage{

    uint integerValue;
    
    mapping(string=>string) keyValue;

    address creator;

    function SimpleStorage(){
         // default value is 1000
         integerValue = 1000;
         creator = msg.sender;
	}

    function setIntegerValue(uint _value)
    public{
         integerValue = _value;
    }

    function getIntegerValue() 
    constant 
    returns(uint){
         return integerValue;
    }

    function getValue(string key)
    constant
    returns(string){
        return keyValue[key];
    }

    function setKeyValue(string key,string value)
    public{
        keyValue[key] = value;
    }

    function getCreator() 
    constant 
    returns(address){
         return creator;
    }
}