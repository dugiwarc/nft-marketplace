// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address contractAddress;

    constructor(address marketplaceAddress) ERC721("Metaverse Tokens", "METT") {
        contractAddress = marketplaceAddress;
    }

    // Mint the token and set it for sale in a subsequent transaction
    function createToken(string memory tokenURI) public returns (uint) {
        // Increment the value starting at 0
        _tokenIds.increment();
        
        // 
        uint256 newItemId = _tokenIds.current();

        // Mint the token
        _mint(msg.sender, newItemId);

        // Set the token URI
        _setTokenURI(newItemId, tokenURI);
        
        // Give the marketplace the approval for users to transact this token
        setApprovalForAll(contractAddress, true);

        // To put it for sale we need the id
        return newItemId;
    }
}

