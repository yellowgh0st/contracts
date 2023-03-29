// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/proxy/ClonesUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

/// @custom:security-contact security@dripps.xyz
contract DrippsEventFactory is Initializable, OwnableUpgradeable, UUPSUpgradeable {
		using AddressUpgradeable for address;
    using ClonesUpgradeable for address;

		address private _eventImplementation;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor () initializer {
        _disableInitializers();
    }

    event NewEvent(address instance);
		event NewEventImplementation(address implementation);

		/**
     * @dev Sets the value of the `EventImplementation`.
   	 */
    function eventImplementation_set(
			address implementation
		) external onlyOwner {
    		eventImplementation_set_unchained(implementation);
    }

		function eventImplementation_set_unchained(
			address implementation
		) internal onlyOwner {
				_eventImplementation = implementation;
				emit NewEventImplementation(_eventImplementation);
		}

		/**
    	* @dev Returns the value of the `eventImplementation`.
    	*/
    function eventImplementation() external view virtual returns (address) {
        return _eventImplementation;
    }

    function eventCreate(
			string memory name,
			uint256 cap,
			uint256 starts,
			uint256 ends,
			int256 lat,
			int256 long
		) external payable {
        _initAndEmit(
					_eventImplementation.clone(),
					abi.encodeWithSignature(
                "initialize(address,string,uint256,uint256,uint256,int256,int256)",
								msg.sender,
                string(abi.encode(name)),
								cap,
								starts,
								ends,
								lat,
								long
            )
				);
    }

    function eventCreateDeterministic(
			  bytes32 salt,
				string memory name,
				uint256 cap,
				uint256 starts,
				uint256 ends,
				int256 lat,
				int256 long
    ) external payable {
        _initAndEmit(
					_eventImplementation.cloneDeterministic(salt),
					abi.encodeWithSignature(
                "initialize(address,string,uint256,uint256,uint256,int256,int256)",
								msg.sender,
                string(abi.encode(name)),
								cap,
								starts,
								ends,
								lat,
								long
            )
				);
    }

    function predictDeterministicAddress(bytes32 salt) external view returns (address predicted) {
        return _eventImplementation.predictDeterministicAddress(salt);
    }

    function _initAndEmit(address instance, bytes memory initdata) private {
        if (initdata.length > 0) {
            instance.functionCallWithValue(initdata, msg.value);
        }
        emit NewEvent(instance);
    }

    function initialize() initializer public {
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}
}
