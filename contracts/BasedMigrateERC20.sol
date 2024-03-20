// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {IERC165} from "@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol";
import {ILegacyMintableERC20, IOptimismMintableERC20} from "./interface/IOptimismMintableERC20.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**
 * @title BasedMigrateERC20
 * @notice BasedMigrateERC20 is adapted from OptimismMintableERC20 to be initialized using Cloning.
 *         Source code for OptimismMintableERC20:
 *         https://github.com/ethereum-optimism/optimism/blob/master/packages/contracts-bedrock/contracts/universal/OptimismMintableERC20.sol
 */
contract BasedMigrateERC20 is Initializable, ERC20Upgradeable, IOptimismMintableERC20, ILegacyMintableERC20 {
    // more lean than Semver and fullfils same requirements
    string public constant version = "1.0.0";
    /**
     * @notice Address of the corresponding version of this token on the remote chain.
     */
    address public REMOTE_TOKEN;

    /**
     * @notice Address of the StandardBridge on this network.
     */
    address public BRIDGE;

    /**
     * @notice Emitted whenever tokens are minted for an account.
     *
     * @param account Address of the account tokens are being minted for.
     * @param amount  Amount of tokens minted.
     */
    event Mint(address indexed account, uint256 amount);

    /**
     * @notice Emitted whenever tokens are burned from an account.
     *
     * @param account Address of the account tokens are being burned from.
     * @param amount  Amount of tokens burned.
     */
    event Burn(address indexed account, uint256 amount);

    error OnlyBridgeAllowed();

    constructor() {
        // disable initializer on implementation contract
        _disableInitializers();
    }

    /**
     * @custom:semver 1.0.0
     *
     * @param _bridge      Address of the L2 standard bridge.
     * @param _remoteToken Address of the corresponding L1 token.
     * @param _name        ERC20 name.
     * @param _symbol      ERC20 symbol.
     */
    function initialize(address _bridge, address _remoteToken, string memory _name, string memory _symbol)
        external
        initializer
    {
        __ERC20_init(_name, _symbol);
        REMOTE_TOKEN = _remoteToken;
        BRIDGE = _bridge;
    }

    /**
     * @notice Allows the StandardBridge on this network to mint tokens.
     *
     * @param _to     Address to mint tokens to.
     * @param _amount Amount of tokens to mint.
     */
    function mint(address _to, uint256 _amount)
        external
        virtual
        override(IOptimismMintableERC20, ILegacyMintableERC20)
    {
        _requireBridge();
        _mint(_to, _amount);
        emit Mint(_to, _amount);
    }

    /**
     * @notice Allows the StandardBridge on this network to burn tokens.
     *
     * @param _from   Address to burn tokens from.
     * @param _amount Amount of tokens to burn.
     */
    function burn(address _from, uint256 _amount)
        external
        virtual
        override(IOptimismMintableERC20, ILegacyMintableERC20)
    {
        _requireBridge();
        _burn(_from, _amount);
        emit Burn(_from, _amount);
    }

    /**
     * @notice ERC165 interface check function.
     *
     * @param _interfaceId Interface ID to check.
     *
     * @return Whether or not the interface is supported by this contract.
     */
    function supportsInterface(bytes4 _interfaceId) external pure returns (bool) {
        bytes4 iface1 = type(IERC165).interfaceId;
        // Interface corresponding to the legacy L2StandardERC20.
        bytes4 iface2 = type(ILegacyMintableERC20).interfaceId;
        // Interface corresponding to the updated OptimismMintableERC20 (this contract).
        bytes4 iface3 = type(IOptimismMintableERC20).interfaceId;
        return _interfaceId == iface1 || _interfaceId == iface2 || _interfaceId == iface3;
    }

    /**
     * @custom:legacy
     * @notice Legacy getter for the remote token. Use REMOTE_TOKEN going forward.
     */
    function l1Token() public view returns (address) {
        return REMOTE_TOKEN;
    }

    /**
     * @custom:legacy
     * @notice Legacy getter for the bridge. Use BRIDGE going forward.
     */
    function l2Bridge() public view returns (address) {
        return BRIDGE;
    }

    /**
     * @custom:legacy
     * @notice Legacy getter for REMOTE_TOKEN.
     */
    function remoteToken() public view returns (address) {
        return REMOTE_TOKEN;
    }

    /**
     * @custom:legacy
     * @notice Legacy getter for BRIDGE.
     */
    function bridge() public view returns (address) {
        return BRIDGE;
    }

    function _requireBridge() internal view {
        if (msg.sender != BRIDGE) revert OnlyBridgeAllowed();
    }
}
