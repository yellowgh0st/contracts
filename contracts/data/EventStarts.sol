// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

/**
 * @dev Extension that adds `starts` time.
 *
 */
abstract contract EventStarts is OwnableUpgradeable {

	  uint256 private _starts;

		/**
     * @dev Sets the value of the `starts`.
     */
    function __EventStarts_set(uint256 starts_) public onlyOwner {
    	__EventStarts_set_unchained(starts_);
    }

    function __EventStarts_set_unchained(uint256 starts_) internal onlyOwner {
    	_starts = starts_;
    }

    /**
     * @dev Returns the value of the `starts`.
     */
    function starts() public view virtual returns (uint256) {
        return _starts;
    }

}
