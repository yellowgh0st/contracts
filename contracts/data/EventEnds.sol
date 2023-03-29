// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

/**
 * @dev Extension that adds `ends` time.
 *
 */
abstract contract EventEnds is OwnableUpgradeable {

	  uint256 private _ends;

		/**
     * @dev Sets the value of the `ends`.
     */
    function __EventEnds_set(uint256 ends_) public onlyOwner {
    	__EventEnds_set_unchained(ends_);
    }

    function __EventEnds_set_unchained(uint256 ends_) internal onlyOwner {
    	_ends = ends_;
    }

    /**
     * @dev Returns the value of the `ends`.
     */
    function ends() public view virtual returns (uint256) {
        return _ends;
    }

}
