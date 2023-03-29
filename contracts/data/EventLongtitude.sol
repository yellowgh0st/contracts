// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

/**
 * @dev Extension that adds location `longtitude`.
 *
 */
abstract contract EventLongtitude is OwnableUpgradeable {

	  int256 private _longtitude;

		/**
     * @dev Sets the value of the `longtitude`.
     */
    function __EventLongtitude_set(int256 longtitude_) public onlyOwner {
    	__EventLongtitude_set_unchained(longtitude_);
    }

    function __EventLongtitude_set_unchained(int256 longtitude_) internal onlyOwner {
    	_longtitude = longtitude_;
    }

    /**
     * @dev Returns the value of the `longtitude`.
     */
    function longtitude() public view virtual returns (int256) {
        return _longtitude;
    }

}
