// SPDX-License-Identifier: GPL-3.0

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol';
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol';

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Betting
 * @dev Implements betting process along with payments
 */
 
 contract Betting is Ownable{
     
     
     using SafeMath for uint256;
     
     
     address payable wallet;
     uint256 public minimumBet;
     address payable[] public players;
  //   uint256 public escrowTotalAmount;

     
     constructor(address payable _wallet,uint256 _minimumBet){
         
          //escrow = new Escrow();
          wallet = _wallet;
          minimumBet = _minimumBet;
     }
     
     struct Bet{
         
         uint256 choice;
         uint256 betAmount;
     }
     
     mapping(address => Bet) public betChoice;
     
     function checkPlayerBet(address _player)public view returns (bool){
         for(uint256 i=0;i<players.length;i++){
             if(players[i]==_player)
             return true;
         }
         return false;
     }
     
     function placeBet( uint256 _choice ) public payable {
         
         require(players.length<=2,"only two participants allowed");
         require( !checkPlayerBet(msg.sender)) ;
         Bet storage bet = betChoice[msg.sender];
         require( msg.value >= minimumBet,"bet amount should be greater than or equal to minimum bet amount" );
         
         
         bet.choice = _choice;
         bet.betAmount = msg.value;
         players.push(payable(msg.sender));

     }
     
   
   function balance() external view onlyOwner returns (uint256) {
       
       // escrowTotalAmount = escrow.depositsOf(this);
        return (address(this).balance);
    }
     
     function getPrizes(uint256 _winningChoice) onlyOwner public {
         
         uint256 escrowBalance = (address(this).balance);
         uint256 winningAmount = (escrowBalance * 99)/100;
         uint256 appAccount = escrowBalance - winningAmount;
         for(uint256 i=0;i<players.length;i++){
             if(betChoice[players[i]].choice == _winningChoice){
                 
                 payable(players[i]).transfer(winningAmount);
                 payable(wallet).transfer(appAccount);
              //  escrow.withdraw.value(winningAmount)(payable(players[i]));
               //escrow.withdraw.value(appAccount)(wallet);
               delete betChoice[players[i]];
              
         }
           // Delete all the players
         // players.length = 0;
          
     }
     delete players;
 }
 }
