/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract TestSale at 0x8f098c013158f9151a21e06a958cdd8756752696
*/
pragma solidity 0.4.18;

contract TestSale {

  address public owner;
  bool public active;
  mapping (address => uint256) public participation;

  modifier ownerOnly() {
    require(msg.sender == owner);
    _;
  }

  modifier isActive() {
    require(active);
    _;
  }

  function TestSale() public {
    owner = msg.sender;
    active = false;
  }

  function setActive(bool _active) public ownerOnly {
    active = _active;
  }

  function () external payable isActive {
    participate(msg.sender);
  }

  function participate(address _recipient) public payable isActive {
    participation[_recipient] = participation[_recipient] + msg.value;
    owner.transfer(msg.value);
  }

}