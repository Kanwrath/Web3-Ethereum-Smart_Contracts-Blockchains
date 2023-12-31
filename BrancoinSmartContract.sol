//Exercise in Smart Contracts
//Brancoin ICO
//Version of compiler
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract brancoin_ico {

    //Introducing maximum OR total number of Brancoins available for sale
    uint public max_brancoins = 1000000;

    //Introducing the USD to Brancoins conversion rate
    uint public usd_to_brancoins = 1000;

    //Introducing total number of Brancoins that have been bought by investors
    uint public total_brancoins_bought = 0;

    //Mapping from the investor address to its equity in Brandcoins and USD
    mapping(address => uint) equity_brancoins;
    mapping(address => uint) equity_usd;

    //Checking if an investor can buy Brancoins
    modifier can_buy_brancoins(uint usd_invested) {
            require (usd_invested * usd_to_brancoins + total_brancoins_bought <= max_brancoins);
            _;
    }

    //Getting the equity in Brancoins of an investor
    function equity_in_brancoins(address investor) external view returns (uint) {
        return equity_brancoins[investor];
    
    }
    //Getting the equity in USD of an investor
    function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }

    //Buying Brancoins
    function buy_brancoins(address investor, uint usd_invested) external
    can_buy_brancoins(usd_invested) {
        uint brancoins_bought = usd_invested * usd_to_brancoins; 
        equity_brancoins[investor] += brancoins_bought; 
        equity_usd[investor] = equity_brancoins[investor] / 1000;
        total_brancoins_bought += brancoins_bought;

    }
    
    //Sell Brancoins
    function sell_brancoins(address investor, uint brancoins_sold) external {
        equity_brancoins[investor] -= brancoins_sold; 
        equity_usd[investor] = equity_brancoins[investor] / 1000;
        total_brancoins_bought -= brancoins_sold;
    }

}

