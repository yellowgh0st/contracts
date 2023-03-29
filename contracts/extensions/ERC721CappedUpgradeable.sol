// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/ERC20Capped.sol)

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**
 * @dev Extension of {ERC721} that adds a cap to the supply.
 *
 * @custom:storage-size 51
 */
abstract contract ERC721CappedUpgradeable is Initializable, ERC721Upgradeable, ERC721EnumerableUpgradeable {

	  uint256 private _cap;

    /**
     * @dev Sets the value of the `cap`.
     */
    function __ERC721Capped_set(uint256 cap_) internal {
        __ERC721Capped_set_unchained(cap_);
    }

    function __ERC721Capped_set_unchained(uint256 cap_) internal {
        require(cap_ > 0, "ERC721Capped: cap is 0");
        _cap = cap_;
    }

    /**
     * @dev Returns the cap on the token's total supply.
     */
    function cap() public view virtual returns (uint256) {
        return _cap;
    }

    /**
     * @dev See {ERC721-_mint}.
     */
    function _safeMint(address to, uint256 tokenId) internal virtual override {
        require(ERC721EnumerableUpgradeable.totalSupply() < cap(), "ERC721Capped: cap exceeded");
        super._safeMint(to, tokenId, "");
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;

		function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
				internal
				virtual
				override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
    {
      	super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

		function supportsInterface(bytes4 interfaceId)
				public
				view
				virtual
				override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
				returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
