/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract Presscoins at 0x5b8d776e4aecfebd8d03cad7d94f23424de1733a
*/
pragma solidity ^0.4.16;

/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/179
 */
contract ERC20Basic {
  uint256 public totalSupply;
  function balanceOf(address who) constant returns (uint256);
  function transfer(address to, uint256 value) returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 is ERC20Basic {
  function allowance(address owner, address spender) constant returns (uint256);
  function transferFrom(address from, address to, uint256 value) returns (bool);
  function approve(address spender, uint256 value) returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  function mul(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal constant returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal constant returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }

}

/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
contract BasicToken is ERC20Basic {

  using SafeMath for uint256;

  mapping(address => uint256) balances;

  /**
  * @dev transfer token for a specified address
  * @param _to The address to transfer to.
  * @param _value The amount to be transferred.
  */
  function transfer(address _to, uint256 _value) returns (bool) {
    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    Transfer(msg.sender, _to, _value);
    return true;
  }

  /**
  * @dev Gets the balance of the specified address.
  * @param _owner The address to query the the balance of.
  * @return An uint256 representing the amount owned by the passed address.
  */
  function balanceOf(address _owner) constant returns (uint256 balance) {
    return balances[_owner];
  }

}

/**
 * @title Standard ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * @dev https://github.com/ethereum/EIPs/issues/20
 * @dev Based on code by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 */
contract StandardToken is ERC20, BasicToken {

  mapping (address => mapping (address => uint256)) allowed;

  /**
   * @dev Transfer tokens from one address to another
   * @param _from address The address which you want to send tokens from
   * @param _to address The address which you want to transfer to
   * @param _value uint256 the amout of tokens to be transfered
   */
  function transferFrom(address _from, address _to, uint256 _value) returns (bool) {
    var _allowance = allowed[_from][msg.sender];

    // Check is not needed because sub(_allowance, _value) will already throw if this condition is not met
    // require (_value <= _allowance);

    balances[_to] = balances[_to].add(_value);
    balances[_from] = balances[_from].sub(_value);
    allowed[_from][msg.sender] = _allowance.sub(_value);
    Transfer(_from, _to, _value);
    return true;
  }

  /**
   * @dev Aprove the passed address to spend the specified amount of tokens on behalf of msg.sender.
   * @param _spender The address which will spend the funds.
   * @param _value The amount of tokens to be spent.
   */
  function approve(address _spender, uint256 _value) returns (bool) {

    // To change the approve amount you first have to reduce the addresses`
    //  allowance to zero by calling `approve(_spender, 0)` if it is not
    //  already 0 to mitigate the race condition described here:
    //  https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
    require((_value == 0) || (allowed[msg.sender][_spender] == 0));

    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

  /**
   * @dev Function to check the amount of tokens that an owner allowed to a spender.
   * @param _owner address The address which owns the funds.
   * @param _spender address The address which will spend the funds.
   * @return A uint256 specifing the amount of tokens still available for the spender.
   */
  function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
    return allowed[_owner][_spender];
  }

}

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {

  address public owner;

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) onlyOwner {
    require(newOwner != address(0));
    owner = newOwner;
  }

}

/**
 * @title Burnable Token
 * @dev Token that can be irreversibly burned (destroyed).
 */
contract BurnableToken is StandardToken {

  /**
   * @dev Burns a specific amount of tokens.
   * @param _value The amount of token to be burned.
   */
  function burn(uint _value) public {
    require(_value > 0);
    address burner = msg.sender;
    balances[burner] = balances[burner].sub(_value);
    totalSupply = totalSupply.sub(_value);
    Burn(burner, _value);
  }

  event Burn(address indexed burner, uint indexed value);

}

contract Presscoins is BurnableToken {

  string public constant name = "Presscoins";

  string public constant symbol = "PRESS";

  uint32 public constant decimals = 18;

  uint256 public INITIAL_SUPPLY = 100000000 * 1 ether;

  function Presscoins() {
    totalSupply = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
  }

}

contract Crowdsale is Ownable {

  using SafeMath for uint;

  address multisig;

  address restricted;

  Presscoins public token = new Presscoins();

  uint public start;

  uint public period;

  uint per_p_sale;

  uint per_sale;

  uint start_ico;

  uint sale_pre_sale;
  uint sale_1_week;
  uint sale_2_week;
  uint sale_3_week;
  uint sale_4_week;
  uint sale_5_week;

  uint rate;
  uint256 public presaleTokens;
  uint256 public preSaleSupply;
  uint256 public restrictedTokens;
  uint256 public ini_supply;
  function Crowdsale() {
    multisig = 0xB4ac5FF29F9D44976e0Afcd58A52f490e1F5B96A;
    restricted = 0x4DBe3d19A87EC865FD052736Ccf9596E668DEdF4;
    rate = 2000000000000000000000;
    start = 1509498061;
    period = 80;
    per_p_sale = 5;
    per_sale = 7;
    sale_pre_sale = 50;
    sale_1_week = 40;
    sale_2_week = 30;
    sale_3_week = 20;
    sale_4_week = 10;
    sale_5_week = 5;
    preSaleSupply = 0;
    presaleTokens    = 40000000 * 1 ether;
    restrictedTokens = 30000000 * 1 ether;

    token.transfer(restricted, restrictedTokens);
  }

  modifier saleIsOn() {
    require(now > start && now < start + period * 1 days);
    _;
  }

  function setStart(uint _start) public onlyOwner {
    start = _start;
  }

  function setPeriod(uint _period) public onlyOwner {
    period = _period;
  }

  function setSail(uint _sale_pre_sale, uint _sale_1_week, uint _sale_2_week, uint _sale_3_week, uint _sale_4_week, uint _sale_5_week) public onlyOwner {
    sale_pre_sale = _sale_pre_sale;
    sale_1_week = _sale_1_week;
    sale_2_week = _sale_2_week;
    sale_3_week = _sale_3_week;
    sale_4_week = _sale_4_week;
    sale_5_week = _sale_5_week;
  }

  function createTokens() saleIsOn payable {
    uint tokens = rate.mul(msg.value).div(1 ether);
    uint bonusTokens = 0;
    start_ico = start + per_p_sale * 1 days;
    multisig.transfer(msg.value);
    if(now < start_ico)
    {
      require(preSaleSupply <= presaleTokens);
      bonusTokens = tokens.div(100).mul(sale_pre_sale);
    } else if(now >= start_ico && now < start_ico + (per_sale * 1 days)) {
      bonusTokens = tokens.div(100).mul(sale_1_week);
    } else if(now >= start_ico + (per_sale * 1 days) && now < start_ico + (per_sale * 1 days).mul(2)) {
      bonusTokens = tokens.div(100).mul(sale_2_week);
    } else if(now >= start_ico + (per_sale * 1 days).mul(2) && now < start_ico + (per_sale * 1 days).mul(3)) {
      bonusTokens = tokens.div(100).mul(sale_3_week);
    } else if(now >= start_ico + (per_sale * 1 days).mul(3) && now < start_ico + (per_sale * 1 days).mul(4)) {
      bonusTokens = tokens.div(100).mul(sale_4_week);
    } else if(now >= start_ico + (per_sale * 1 days).mul(4) && now < start_ico + (per_sale * 1 days).mul(5)) {
      bonusTokens = tokens.div(100).mul(sale_5_week);
    }
    uint tokensWithBonus = tokens.add(bonusTokens);
    preSaleSupply = preSaleSupply.add(tokensWithBonus);
    token.transfer(msg.sender, tokensWithBonus);
  }

  function() external payable {
    createTokens();
  }

}




/** PressOnDemand is the first decentralized ondemand platform with in-Dapp store,
  * Powered by smartcontracts utilize blockchain technology. Users can instantly book and
  * schedule a service provider to their home or office or most locations with the press of a
  * button. The decentralized design of the PressOnDemand platform eliminates middlemen,
  * making the whole service more efficient and transparent as well as saving money for both
  * the service provider and the customer.
  /*