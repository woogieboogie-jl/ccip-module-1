// script/CCIPTokenSender.s.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {CCIPTokenAndDataReceiver} from "../src/CCIPTokenAndDataReceiver.sol";

contract DeployCCIPTokenAndDataReceiver is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        
        address arbSepoliaRouter = 0x2a9C5afB0d0e4BAb2BCdaE109EC4b0c4Be15a165;
        uint256 price = 100;

        CCIPTokenAndDataReceiver receiver = new CCIPTokenAndDataReceiver(
            arbSepoliaRouter,
            price
        );

        console.log(
            "CCIPTokenAndDataReceiver deployed to ",
            address(receiver)
        );

        vm.stopBroadcast();
    }
}
