pragma solidity ^0.4.15;

import './Queue.sol';
import './Token.sol';

/**
 * @title Crowdsale
 * @dev Contract that deploys `Token.sol`
 * Is timelocked, manages buyer queue, updates balances on `Token.sol`
 */

// Crowdsale has to track the addresses of both Token and Queue and they have to track the address of Crowdsale
contract Crowdsale {

   Token public token;
   Queue public queue;

   address public owner;

   uint public soldTokens;
   uint public buyPrice;
   uint public sellPrice;
   uint public startTime = now;
   uint public endTime = startTime + 30 days;

   mapping(address => uint) public balanceOf; // Crowdsale spec says this is in Token

   modifier onlyOwner {
       require(msg.sender == owner);
       _;
   }

   function Crowdsale(
       uint256 initialSupply,
       string tokenName,
       string tokenSymbol,
       uint8 decimalUnits)
       public {
           owner = msg.sender;
           token = new Token(
               initialSupply,
               tokenName,
               tokenSymbol,
               decimalUnits);
           queue = new Queue( //arguments here
               );
           balanceOf[this] = initialSupply;
       }

   function setPrices(uint newSellPrice, uint newBuyPrice) public onlyOwner {
       sellPrice = newSellPrice; // use this price 1000000000000000
       buyPrice = newBuyPrice;
       }

   function buy() public payable returns (uint amount) {

       require(balanceOf[this] >= amount);
       require(now < endTime && now > startTime);
       // require(queue.queuePos(msg.sender) == 0 && queue.addrQueue(1) != 0);
       amount = msg.value / buyPrice;
       token.incrementBalance(msg.sender, amount);
       balanceOf[this] -= amount;
       soldTokens += amount;
       return amount;
   }

   function refund(uint amount) public returns (uint revenue) {
       require(balanceOf[msg.sender] >= amount);
       require(now < endTime && now > startTime);
       balanceOf[this] += amount;
       balanceOf[msg.sender] -= amount;
       token.decrementBalance(msg.sender, amount);
       soldTokens += amount;
       revenue = amount * sellPrice;
       msg.sender.transfer(revenue);
       return revenue;
   }

   function mintNewTokens(uint amount) public onlyOwner {
       token.mintNewTokens(amount);
       balanceOf[this] += amount;
   }

   function burnTokens(uint amount) public onlyOwner {
       token.burn(amount);
       balanceOf[this] -= amount;
   }

   function forward() public returns(bool) {
       if(now >= endTime) {
       owner.transfer(this.balance);
       return true;
       } else {
           return false;
       }
   }

   function checkTime() public view returns (uint) {
       return endTime - now;
   }
}
