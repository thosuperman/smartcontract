/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract NetkillerToken at 0x9abcf16f6685fe1f79168534b1d30056c90b8a8a
*/
pragma solidity ^0.4.21;

contract NetkillerToken {
  string public name;
  string public symbol;
  uint public decimals;

  event Transfer(address indexed from, address indexed to, uint256 value);

  /* This creates an array with all balances */
  mapping (address => uint256) public balanceOf;

  function NetkillerToken(uint256 initialSupply, string tokenName, string tokenSymbol, uint decimalUnits) public {
    balanceOf[msg.sender] = initialSupply;
    name = tokenName;
    symbol = tokenSymbol;
    decimals = decimalUnits;
  }

  /* Send coins */
  function transfer(address _to, uint256 _value) public {
    /* Check if the sender has balance and for overflows */
    require(balanceOf[msg.sender] >= _value && balanceOf[_to] + _value >= balanceOf[_to]);

    /* Add and subtract new balances */
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;

    /* Notify anyone listening that this transfer took place */
    emit Transfer(msg.sender, _to, _value);
  }
}