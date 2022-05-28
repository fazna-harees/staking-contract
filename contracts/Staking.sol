// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract NFTStaker is ERC1155Holder {
    IERC1155 public parentNFT;
    using SafeMath for uint256;

    struct Stake {
        uint256 tokenId;
        uint256 amount;
        uint256 timestamp;
    }
    mapping(address => Stake) public stakes;
    mapping(address => uint256) public stakingTime;

    constructor() {
        parentNFT = IERC1155(0x8426f3344c8Bea504a1bd12f67f34730c9F868cC);
    }

    function stake(uint _tokenId, uint _amount) public {
        stakes[msg.sender] = Stake(_tokenId, _amount, block.timestamp);
        parentNFT.safeTransferFrom(msg.sender,address(this),_tokenId,_amount,"0x00");
    }

    function unstake(uint _tokenId, uint _amount) public {
        parentNFT.safeTransferFrom(address(this),msg.sender,_tokenId,_amount,"0x00");
        stakingTime[msg.sender] = stakingTime[msg.sender].add(block.timestamp - stakes[msg.sender].timestamp);
        delete stakes[msg.sender];
    }

    function onERC1155Received(address operator, address from, uint256 id, uint256 value, bytes4 data) external returns(bytes4) {
        return bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"));
    }
}
