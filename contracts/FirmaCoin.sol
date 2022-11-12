// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.13 to v0.9.0
pragma solidity ^0.8.13;

import "./ConvertLib.sol";

// This is just a simple example of a coin-like contract.
// It is not ERC20 compatible and cannot be expected to talk to other
// coin/token contracts.

contract FirmaCoin {
    uint public firmaLand;

    mapping(address => uint) balances;
    mapping(address => uint) cornSupply;
    mapping(address => uint) tomatoSupply;
    mapping(address => uint) eggplantSupply;

    // This event is meant for the Transfer of coin
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // This event is meant when a crop is purchased
    event BuyCorn(address indexed _from, address indexed _to, uint amount);
    event BuyTomato(address indexed _from, address indexed _to, uint amount);
    event BuyEggplant(address indexed _from, address indexed _to, uint amount);

    constructor() {
        balances[tx.origin] = 10000;
        cornSupply[tx.origin] = 0;
        tomatoSupply[tx.origin] = 0;
        eggplantSupply[tx.origin] = 0;
        firmaLand = 9;
    }

    function sendCoin(address receiver, uint amount)
        public
        returns (bool sufficient)
    {
        if (balances[msg.sender] < amount) return false;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function getBalanceInEth(address addr) public view returns (uint) {
        return ConvertLib.convert(getBalance(addr), 2);
    }

    function getBalance(address addr) public view returns (uint) {
        return balances[addr];
    }

    function getLand(address addr) public view returns (uint) {
        return land;
    }

    function buyCorn(address addr, uint amount) returns (uint) {}
}
