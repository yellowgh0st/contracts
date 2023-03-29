// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

/**
 * @dev Extension that adds `canceled` status.
 *
 */
abstract contract EventCanceled is OwnableUpgradeable {

	  bool private _canceled;

		/**
     * @dev Sets the value of the `canceled`.
     */
    function __EventCanceled_set(bool canceled_) public onlyOwner {
    	__EventCanceled_set_unchained(canceled_);
    }

    function __EventCanceled_set_unchained(bool canceled_) internal onlyOwner {
    	_canceled = canceled_;
    }

    /**
     * @dev Returns the value of the `canceled`.
     */
    function canceled() public view virtual returns (bool) {
        return _canceled;
    }

}
