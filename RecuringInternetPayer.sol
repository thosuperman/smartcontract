/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract RecuringInternetPayer at 0xb887c328dc993103386403e06222a563b4ff76c3
*/
pragma solidity ^0.4.24;
contract Token {
    function balanceOf(address guy) public view returns (uint);
    function transfer(address dst, uint wad) public returns (bool);
}

contract RecuringInternetPayer{
    address zac  = 0x1F4E7Db8514Ec4E99467a8d2ee3a63094a904e7A;
    address josh = 0x650a7762FdB32BF64849345209DeaA8F9574cBC7;
    Token dai = Token(0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359); //DAI token address
    uint constant perSecondDaiParticlePayout = 28935185185185 ; // $75 x 10^18 / (60*60*24*30)
    uint public totalPaid;
    uint createdAt;
    
    constructor() public { createdAt = now; }

    modifier onlyZacOrJosh(){ require(msg.sender == zac || msg.sender == josh); _; }
    
    function payJosh() public{
        uint currentPayment = perSecondDaiParticlePayout * (now - createdAt) - totalPaid;
        dai.transfer(josh, currentPayment);
        totalPaid += currentPayment;
    }
    function withdraw() public onlyZacOrJosh{ // discontinue service
        payJosh();
        dai.transfer(zac, dai.balanceOf(this));
    }
}