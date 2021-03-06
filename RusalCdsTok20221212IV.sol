/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract RusalCdsTok20221212IV at 0xd0a8b8d49cd9fa798171b36f2297bec75981c358
*/
pragma solidity 		^0.4.21	;						
									
contract	RusalCdsTok20221212IV				{				
									
	mapping (address => uint256) public balanceOf;								
									
	string	public		name =	"	RusalCdsTok20221212IIV		"	;
	string	public		symbol =	"	RUSTOKIV		"	;
	uint8	public		decimals =		18			;
									
	uint256 public totalSupply =		289393720156273000000000000					;	
									
	event Transfer(address indexed from, address indexed to, uint256 value);								
									
	function SimpleERC20Token() public {								
		balanceOf[msg.sender] = totalSupply;							
		emit Transfer(address(0), msg.sender, totalSupply);							
	}								
									
	function transfer(address to, uint256 value) public returns (bool success) {								
		require(balanceOf[msg.sender] >= value);							
									
		balanceOf[msg.sender] -= value;  // deduct from sender's balance							
		balanceOf[to] += value;          // add to recipient's balance							
		emit Transfer(msg.sender, to, value);							
		return true;							
	}								
									
	event Approval(address indexed owner, address indexed spender, uint256 value);								
									
	mapping(address => mapping(address => uint256)) public allowance;								
									
	function approve(address spender, uint256 value)								
		public							
		returns (bool success)							
	{								
		allowance[msg.sender][spender] = value;							
		emit Approval(msg.sender, spender, value);							
		return true;							
	}								
									
	function transferFrom(address from, address to, uint256 value)								
		public							
		returns (bool success)							
	{								
		require(value <= balanceOf[from]);							
		require(value <= allowance[from][msg.sender]);							
									
		balanceOf[from] -= value;							
		balanceOf[to] += value;							
		allowance[from][msg.sender] -= value;							
		emit Transfer(from, to, value);							
		return true;							
	}								
}