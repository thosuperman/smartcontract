/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract NFT at 0x49fb8ab3fed4003c8c5805496cbc3a19760e67b1
*/
pragma solidity ^0.4.4;


contract NFToken {

    function totalSupply() constant returns (uint256 supply) {}
    function balanceOf(address _owner) constant returns (uint256 balance) {}
    function transfer(address _to, uint256 _value) returns (bool success) {}
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {}
    function approve(address _spender, uint256 _value) returns (bool success) {}
    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {}
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}

contract NewFinanceToken is NFToken {

    function transfer(address _to, uint256 _value) returns (bool success) {

        if (balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else {return false;}
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {

        if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
            balances[_to] += _value;
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            Transfer(_from, _to, _value);
            return true;
        } else {return false;}
    }

    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
      return allowed[_owner][_spender];
    }

    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    uint256 public totalSupply;
}

contract NFT is NewFinanceToken { 


    string public name;                
    uint8 public decimals;           
    string public symbol;                
    string public version = "1.0"; 
    uint256 public unitsOneEthCanBuy;    
    uint256 public totalEthInWei;         
    address public fundsWallet;           

 
    function NFT() {
        balances[msg.sender] = 10000000000000000;               
        totalSupply = 10000000000000000;                        
        name = "NewFinanceToken";                                              
        decimals = 8;                                               
        symbol = "NFT";                                            
                                            
        fundsWallet = msg.sender;                                   
                          
    }
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);

        if (!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) {throw;}
        return true;
    }
}