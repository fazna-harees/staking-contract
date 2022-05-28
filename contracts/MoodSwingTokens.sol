// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MoodSwing is ERC1155 {
    uint256 public constant HAPPY = 1;
    uint256 public constant SAD = 2;

    constructor() ERC1155("https://bafybeigl4hbd4mv4vvlg46ovvdn5lrrb3lri2pcsetc4bmvhotgakrrjhq.ipfs.nftstorage.link/{id}.json") {
        _mint(msg.sender, HAPPY, 100, "");
        _mint(msg.sender, SAD, 100, "");
    }

    function uri(uint _tokenId) public override pure returns(string memory) {
        return string(
            abi.encodePacked(
                "https://bafybeigl4hbd4mv4vvlg46ovvdn5lrrb3lri2pcsetc4bmvhotgakrrjhq.ipfs.nftstorage.link/",
                Strings.toString(_tokenId),
                ".json"
            )
        );
    }
} 