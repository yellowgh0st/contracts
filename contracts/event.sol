// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "./extensions/ERC721CappedUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "./data/EventStarts.sol";
import "./data/EventEnds.sol";
import "./data/EventLatitude.sol";
import "./data/EventLongtitude.sol";
import "./data/EventCanceled.sol";

/// @custom:security-contact security@dripps.xyz
contract DrippsEvent is Initializable, ERC721Upgradeable, ERC721EnumerableUpgradeable,
ERC721URIStorageUpgradeable, PausableUpgradeable, ERC721CappedUpgradeable, OwnableUpgradeable,
ERC721BurnableUpgradeable, EventStarts, EventEnds, EventLatitude, EventLongtitude, EventCanceled {
    using CountersUpgradeable for CountersUpgradeable.Counter;

    CountersUpgradeable.Counter private _tokenIdCounter;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

		/**
		 * @dev This initializer function substitues constructor.
		 * Initializes contract's instance with supplied values.
		 */
    function initialize(
				address owner,
			  string memory eventName,
				uint256 cap,
				uint256 starts,
				uint256 ends,
				int256 lat,
				int256 long
		) public initializer payable {
        __ERC721_init(eventName, "Dripps.app");
        __ERC721Enumerable_init();
				__ERC721Capped_set(cap);
        __ERC721URIStorage_init();
        __Pausable_init();
        __Ownable_init();
				__EventStarts_set(starts);
				__EventEnds_set(ends);
				__EventLatitude_set(lat);
				__EventLongtitude_set(long);
				__EventCanceled_set(false);
        __ERC721Burnable_init();
				transferOwnership(owner);
    }

		function setCap(uint256 _cap) external onlyOwner {
        __ERC721Capped_set(_cap);
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function safeMint(address to, string memory uri)
				public
				whenNotPaused
		{
				require(msg.sender == owner() || ERC721EnumerableUpgradeable.totalSupply() < cap(), "ERC721: cap exceeded");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

		/**
		 * @dev The following functions are overrides required by Solidity.
		 */
    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        whenNotPaused
        override(ERC721Upgradeable, ERC721EnumerableUpgradeable, ERC721CappedUpgradeable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

		function _safeMint(address to, uint256 tokenId)
				internal
				virtual
    		override(ERC721Upgradeable, ERC721CappedUpgradeable)
		{
        super._safeMint(to, tokenId, "");
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Upgradeable, ERC721EnumerableUpgradeable, ERC721CappedUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
