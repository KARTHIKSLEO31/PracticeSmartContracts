// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Factory{
    
    address public admin;
    bool public isActive = true;
    
    constructor(){
        admin = msg.sender;
    }
    
    function deActivate() external  {
        require(msg.sender == admin);
        isActive = false;
    }
    
    function activeStatus() external returns (bool){
        return isActive;
    }
}
