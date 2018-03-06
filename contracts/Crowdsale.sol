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
     address public tokenAddress;
     address public owner;

     uint public soldTokens;
     uint public buyPrice;
     uint public sellPrice;
     uint public startTime;
     uint public endTime = startTime + 30 days;

     mapping(address => uint) balanceOf;

     function Crowdsale(
         uint256 initialSupply,
         string tokenName,
         string tokenSymbol,
         uint8 decimalUnits)
         public {
             owner = msg.sender;
             tokenAddress = new Token(
                 initialSupply,
                 tokenName,
                 tokenSymbol,
                 decimalUnits

                 );

     }

     function buy() payable returns (uint amount) {
         amount = msg.value / buyPrice;
         require(balanceOf[this] >= amount);
         require(now < endTime && now > startTime);
         balanceOf[msg.sender] += amount;
         balanceOf[this] -= amount;
         Queue.enqueue(msg.sender); // adds address
         // Transfer(this, msg.sender, amount);
         return amount;
     }

     function refund(uint amount) returns (uint revenue) {
         require(balanceOf[msg.sender] >= amount);
         require(now < endTime && now > startTime);
         balanceOf[this] += amount;
         balanceOf[msg.sender] -= amount;
         revenue = amount * sellPrice;
         msg.sender.transfer(revenue);
         // Transfer(msg.sender, this, amount);
         return revenue;
     }

     function _forward() private returns(bool) {
         if(now >= endTime) {
         owner.transfer(this.balance);
         return true;
         } else {
             return false;
         }
     }

 }
