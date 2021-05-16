// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./Factory.sol";
contract MyContract{
    
     Factory factory;
 
   
    constructor(address factoryAddress){
       
         factory = Factory(factoryAddress);
    }
    
   
    
     modifier isContractActive(){
         require(factory.activeStatus() == true);
        _;
    }
    
    function recieve() external payable isContractActive{
        
    }
   
    function withdraw() external payable isContractActive{
       
    }
}
