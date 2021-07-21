// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// Prevent contract being hit with multiple requests (re-entry atacks)
import "@openzeppelin/contracts/security/ReentracyGuard.sol";

contract NFTMarket is ReentracyGuard {
    using Counters for Counters.Counter;

    Counters.Counter private _itemIds;
    Counters.Counter private _itemsSold;

    address payable owner;
    uint256 listingPrice = 0.025 ether;


    constructor() {
        owner = payable(msg.sender);
    }

    struct MarketItem {
        uint itemId;
        address nftContract;
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    // Keep up with the item ids and what we need to do to fetch that item
    mapping(uint256 => MarketItem) private idToMarketItem;

    // Event for when the market item is created
    event MarketItemCreated {
        uint indexed itemId;
        address indexed nftContract;
        uint256 indexed tokenId;
        address seller;
        address owner,
        uint256 price,
        bool sold
    }

    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }

    function createMarketItem(
        address nftContract,
        uint256 tokenId,
        uint256 price
    ) public payable nonReentrant {
       require(price > 0, "Price must be at least 1 wei");
       require(msg.value == listingPrice, "Price must be equal to listing price");

        _itemIds.increment();
        uint256 itemId = _itemIds.current();

        idToMarketItem[itemId] = MarketItem(
            itemId,
            nftContract,
            tokeId,
            payable(msg.sender),
            payable(address(0)),
            price, 
            false
        )

        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);


        emit MarketItemCreated(
            itemId,
            nftContract,
            tokenId,
            msg.sender,
            address(0),
            price,
            false
        )
    }
}