// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockRemoteERC20 is ERC20("Mock", "MOCK") {
    function mint(uint256 _amount) external {
        _mint(msg.sender, _amount);
    }
}