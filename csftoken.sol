/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract csftoken at 0x7f59069b7a01385c14d390c8b7680230464f4a5f
*/
pragma solidity ^0.4.24;

//Cordyceps Sinensis?CSF?
//??  CSF
//???   25??

contract Token{

    uint256 public totalSupply;


function balanceOf(address _owner) constant returns (uint256 balance);
    function transfer(address _to, uint256 _value) returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) returns   
    (bool success);
    function approve(address _spender, uint256 _value) returns (bool success);
    function allowance(address _owner, address _spender) constant returns 
    (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 
    _value);
}

contract StandardToken is Token {
    function transfer(address _to, uint256 _value) returns (bool success) {
        require(balances[msg.sender] >= _value);
        balances[msg.sender] -= _value;//???????????token??_value
        balances[_to] += _value;//???????token??_value
        Transfer(msg.sender, _to, _value);//????????
        return true;
    }


    function transferFrom(address _from, address _to, uint256 _value) returns 
    (bool success) {
      
        require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value);
        balances[_to] += _value;//??????token??_value
        balances[_from] -= _value; //????_from??token??_value
        allowed[_from][msg.sender] -= _value;//??????????_from????????_value
        Transfer(_from, _to, _value);//????????
        return true;
    }
    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }


    function approve(address _spender, uint256 _value) returns (bool success)   
    {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }


    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
        return allowed[_owner][_spender];//??_spender?_owner????token?
    }
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
}

contract csftoken is StandardToken { 

    /* Public variables of the token */
    string public name;                   
    uint8 public decimals;               
    string public symbol;               //token
    string public version = 'v2.0';    

    function csftoken() {
        balances[msg.sender] = 2500000000000000000000000000; // ??token?????????
        totalSupply = 2500000000000000000000000000;         // ??????
        name = "Cordyceps Sinensis";                   // token??
        decimals = 18;           // ????
        symbol = "CSF";             // token??
    }

    /* Approves and then calls the receiving contract */
    
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        //call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesn't have to include a contract in here just for this.
        //receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)
        //it is assumed that when does this that the call *should* succeed, otherwise one would use vanilla approve instead.
        require(_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData));
        return true;
    }

}