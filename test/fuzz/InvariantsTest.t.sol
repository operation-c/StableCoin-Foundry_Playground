// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { Handler } from "./Handler.t.sol";
import { Test, console } from "forge-std/Test.sol";
import { DSCEngine } from "../../src/DSCEngine.sol";
import { DeployDSC } from "../../script/DeployDSC.s.sol";
import { StdInvariant } from "forge-std/StdInvariant.sol";
import { HelperConfig } from "../../script/HelperConfig.s.sol";
import { MockV3Aggregator } from "../mocks/MockV3Aggregator.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { DecentralizedStableCoin } from "../../src/DecentralizedStableCoin.sol";

contract InvariantTest is StdInvariant, Test {
    DSCEngine dsce;
    Handler handler;
    DeployDSC deployer;
    HelperConfig config;
    DecentralizedStableCoin dsc;


    address weth;
    address wbtc;
    
    function setUp() external {
        deployer = new DeployDSC();
        (dsc, dsce, config) = deployer.run();
        (,,weth, wbtc,) = config.activeNetworkConfig();
        handler = new Handler(dsce, dsc);
        targetContract(address(handler));
    }

    // function invariant_protocolMustHaveMoreValueThanTotalSupply() public view {
    //     uint256 totalSupply = dsc.totalSupply();
    //     uint256 totalWethDeposited = IERC20(weth).balanceOf(address(dsce));
    //     uint256 totalWbtcDeposited = IERC20(wbtc).balanceOf(address(dsce));

    //     uint256 wethValue = dsce.getUsdValue(weth, totalWethDeposited);
    //     uint256 wbtcValue = dsce.getUsdValue(wbtc, totalWbtcDeposited);

    //     console.log("time mint called:", handler.timeMintIsCalled());

    //     assert(wethValue + wbtcValue >= totalSupply);        
    // }

    // function invariant_gettersShouldNotRevert() public view {
    //     dsce.getLiquidationBonus();
    //     dsce.getPrecision();
    
}