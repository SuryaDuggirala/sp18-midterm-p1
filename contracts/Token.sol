pragma solidity ^0.4.15;

import './interfaces/ERC20Interface.sol';

/**
 * @title Token
 * @dev Contract that implements ERC20 token standard
 * Is deployed by `Crowdsale.sol`, keeps track of balances, etc.
 */

 contract Token is ERC20Interface {
   uint256 public totalSupply;

   address public crowdsaleTarget;

   mapping(address => uint) public balanceOf;
   mapping(address => uint) public allowance;

   event Transfer(address indexed _from, address indexed _to, uint256 _value);
   event Approval(address indexed _owner, address indexed _spender, uint256 _value);
   event Burn(address _burner, uint _burnAmount);

   	string public name;
 	string public symbol;
 	uint8 public decimals;

 	uint startTime = now;

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

   /// @return Whether the transfer was successful or not
   function transfer(address _to, uint256 _value) public returns (bool success) {
       require(balanceOf[msg.sender] >= _value && balanceOf[_to] + _value >= balanceOf[_to]);
       balanceOf[msg.sender] -= _value;
       balanceOf[_to] += _value;
       return true;
   }
    /// @return Whether the transfer was successful or not
   function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
       balanceOf[_from] -= _value;
       balanceOf[_to] += _value;
       return success;
   }

   /// @notice `msg.sender` approves `_spender` to spend `_value` tokens
   /// @param _spender The address of the account able to transfer the tokens
   /// @param _value The amount of tokens to be approved for transfer
   /// @return Whether the approval was successful or not
   function approve(address _spender, uint256 _value) public returns (bool success) {
       return true;
   }

   /// @param _owner The address of the account owning tokens
   /// @param _spender The address of the account able to transfer the tokens
   /// @return Amount of remaining tokens allowed to spent
   function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
       return 1;
   }

   function burn(uint _burnAmount) public returns(bool) {
         require(balanceOf[msg.sender] >= _burnAmount);
         balanceOf[msg.sender] -= _burnAmount;
         totalSupply -= _burnAmount;
         Burn(msg.sender, _burnAmount);
         return true;
     }


 }
