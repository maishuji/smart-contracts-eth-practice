//SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Greeter  {
    string public yourName;  // data
    
    /* This runs when the contract is executed */
   constructor() {
        yourName = "World";
    } 
   
   
    function set(string memory name) public {
        yourName = name;

    }
    
    function hello() public view returns(string memory) {
        return (yourName);
    }
}