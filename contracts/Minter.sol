// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Coin{
    // Address type : Can store a 20-byte etherium addr
    address public minter;
    // Hash map (key => value)
    mapping (address => uint) public balances;

    // uint is a 256 bits variable
    event Sent(address from, address to, uint amount);

    constructor(){
        minter = msg.sender;
    }

    function mint(address receiver, uint amount) public {
        if(msg.sender != minter) return;
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public {
        if(balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        // Invoke event log of what has been done
        emit Sent(msg.sender, receiver, amount);
    }
}
