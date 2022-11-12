// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.13 to v0.9.0
pragma solidity ^0.8.13;

import "./ConvertLib.sol";

// This is just a simple example of a coin-like contract.
// It is not ERC20 compatible and cannot be expected to talk to other
// coin/token contracts.

contract FirmaCoin {
    uint cornPrice;
    uint tomatoPrice;
    uint eggplantPrice;

    mapping(address => uint) balances;
    mapping(address => uint) cornSupply;
    mapping(address => uint) tomatoSupply;
    mapping(address => uint) eggplantSupply;
    mapping(address => uint) firmaLand;

    // This event is meant for the Transfer of coin
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // This event is meant when a crop is purchased
    event BuyCornTransaction(address indexed _from, uint amount);
    event BuyTomatoTransaction(address indexed _from, uint amount);
    event BuyEggplantTransaction(address indexed _from, uint amount);

    event SellCrops(address indexed_from, address indexed _to);

    constructor() {
        balances[tx.origin] = 10000;
        cornSupply[tx.origin] = 0;
        tomatoSupply[tx.origin] = 0;
        eggplantSupply[tx.origin] = 0;
        firmaLand[tx.origin] = 9;
        cornPrice = 1;
        tomatoPrice = 1;
        eggplantPrice = 1;
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

    // function setLand(address addr) public {
    //     firmaLand[addr] = 9;
    // }

    function getLand(address addr) public view returns (uint) {
        return firmaLand[addr];
    }

    function buyCorn(address addr, uint amount) public returns (uint) {
        require(balances[addr] >= (amount * cornPrice), "Not enough funds.");
        require(firmaLand[addr] >= amount, "Not enough land.");

        cornSupply[addr] += amount;
        firmaLand[addr] -= amount;
        balances[addr] -= amount;
        emit BuyCornTransaction(addr, amount);
        return cornSupply[addr];
    }

    function buyTomato(address addr, uint amount) public returns (uint) {
        require(balances[addr] >= (amount * tomatoPrice), "Not enough funds.");
        require(firmaLand[addr] >= amount, "Not enough land.");

        tomatoSupply[addr] += amount;
        firmaLand[addr] -= amount;
        balances[addr] -= amount;
        emit BuyTomatoTransaction(addr, amount);
        return tomatoSupply[addr];
    }

    function buyEggplant(address addr, uint amount) public returns (uint) {
        require(
            balances[addr] >= (amount * eggplantPrice),
            "Not enough funds."
        );
        require(firmaLand[addr] >= amount, "Not enough land.");

        eggplantSupply[addr] += amount;
        firmaLand[addr] -= amount;
        balances[addr] -= amount;
        emit BuyEggplantTransaction(addr, amount);
        return eggplantSupply[addr];
    }

    function sellCorn(address addr) public returns (uint) {
        balances[addr] += (cornSupply[addr] * cornPrice);
        return balances[addr];
    }

    // function sellCorn(address addr) returns () {}
}
