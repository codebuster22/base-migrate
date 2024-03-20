// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {OptimismMintableERC20} from "../OptimismMintableERC20.sol";
import {Clones} from "@openzeppelin/contracts/proxy/Clones.sol";

contract BasedERC20Factory {
    string public constant version = "1.0.0";
    /**
     * @notice Address of the BasedMigrateERC20 implementation on this chain.
     */
    address public basedMigrateErc20;

    /**
     * @notice Address of the StandardBridge on this chain.
     */
    address public immutable BRIDGE;

    error RemoteTokenCannotBeZeroAddress();

    event BasedMigrateERC20Created(address indexed remoteToken, address indexed localToken, address deployer);

    constructor(address _implementation, address _bridge) {
        basedMigrateErc20 = _implementation;
        BRIDGE = _bridge;
    }

    function beBased(address _remoteToken, string memory _name, string memory _symbol) external returns(address) {
        if(_remoteToken == address(0)) {
            revert RemoteTokenCannotBeZeroAddress();
        }
        // deploy clone
        address newBasedERC20 = Clones.clone(basedMigrateErc20);

        // initialize clone
        OptimismMintableERC20(newBasedERC20).initialize(BRIDGE, _remoteToken, _name, _symbol);

        emit BasedMigrateERC20Created(_remoteToken, newBasedERC20, msg.sender);

        // return
        return newBasedERC20;
    }
}