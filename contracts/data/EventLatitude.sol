// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

/**
 * @dev Extension that adds location `latitude`.
 *
 */
abstract contract EventLatitude is OwnableUpgradeable {

	  int256 private _latitude;

		/**
     * @dev Sets the value of the `latitude`.
     */
    function __EventLatitude_set(int256 latitude_) public onlyOwner {
    	__EventLatitude_set_unchained(latitude_);
    }

    function __EventLatitude_set_unchained(int256 latitude_) internal onlyOwner {
    	_latitude = latitude_;
    }

    /**
     * @dev Returns the value of the `latitude`.
     */
    function latitude() public view virtual returns (int256) {
        return _latitude;
    }

}
