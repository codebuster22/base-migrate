pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {BasedERC20Factory} from "../../contracts/factory/BasedERC20Factory.sol";
import {MockRemoteERC20} from "../../contracts/mocks/MockRemoteERC20.sol";
import {OptimismMintableERC20} from "../../contracts/OptimismMintableERC20.sol";

contract FactoryBase is Test {
    BasedERC20Factory public factory;
    OptimismMintableERC20 public implementation;

    address public bridge = makeAddr("bridge");
    MockRemoteERC20 public remote;

    function setUp() public {
        implementation = new OptimismMintableERC20();
        remote = new MockRemoteERC20();
        factory = new BasedERC20Factory(address(implementation), bridge);
    }
}