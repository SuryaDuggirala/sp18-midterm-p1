pragma solidity ^0.4.15;

import './interfaces/ERC20Interface.sol';

/**
 * @title Token
 * @dev Contract that implements ERC20 token standard
 * Is deployed by `Crowdsale.sol`, keeps track of balances, etc.
 */

 contract Token is ERC20Interface {
    uint256 public totalSupply;
    uint startTime = now;
    uint8 public decimals;

    string public name;
	  string public symbol;

    address public crowdsaleTarget;
    address private owner = crowdsaleTarget;

    mapping(address => uint) public balanceOf;
    mapping(address => uint) public allowance;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event Burn(address _burner, uint _burnAmount);

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

	function Token(
	    uint initialSupply,
	    string tokenName,
	    string tokenSymbol,
	    uint8 decimalUnits)
	    public {
	        balanceOf[msg.sender] = initialSupply;
	        totalSupply = initialSupply;
	        name = tokenName;
	        symbol = tokenSymbol;
	        decimals = decimalUnits;
	        crowdsaleTarget = msg.sender;
	    }
  function balanceOf(address _owner) public view returns (uint256 balance) {
    // return crowdsaleTarget.balanceOf[_owner];
    }

  function incrementBalance(address target, uint amount) public {
      require(msg.sender == owner);
      balanceOf[target] += amount;
      Transfer(crowdsaleTarget, target, amount);
  }

   function decrementBalance(address target, uint amount) public {
        require(msg.sender == owner);
        balanceOf[target] -= amount;
        Transfer(target, crowdsaleTarget, amount);
  }

  function transfer(address _to, uint256 _value) public returns (bool success) {
      require(balanceOf[msg.sender] >= _value && balanceOf[_to] + _value >= balanceOf[_to]);
      balanceOf[msg.sender] -= _value;
      balanceOf[_to] += _value;
      return true;
  }

  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
      balanceOf[_from] -= _value;
      balanceOf[_to] += _value;
      return success;
  }


  function approve(address _spender, uint256 _value) public returns (bool success) {
      return true;
  }


  function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
      return 1;
  }

  function burn(uint _burnAmount) public onlyOwner returns(bool) {
        require(balanceOf[msg.sender] >= _burnAmount);
        balanceOf[msg.sender] -= _burnAmount;
        totalSupply -= _burnAmount;
        Burn(msg.sender, _burnAmount);
        return true;
    }

  function mintNewTokens(uint amount) public onlyOwner returns(bool){
      totalSupply += amount;
  }
}
