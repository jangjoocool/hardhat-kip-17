// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '@klaytn/contracts/KIP/token/KIP17/extensions/KIP17URIStorage.sol';
import '@klaytn/contracts/utils/Counters.sol';
import '@klaytn/contracts/access/Ownable.sol';
import './lib/IERC5192.sol';

contract FdtNFT is KIP17URIStorage, IERC5192, Ownable {
    mapping(uint256 => bool) private lock;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() KIP17("TEST-FDT", "TFDT") {}

    function mintWithLock(address recipient, string memory tokenURI) public onlyOwner {
        uint256 id = _tokenIds.current();
        _mint(recipient, id);
        _setTokenURI(id, tokenURI);
        lock[id] = true;
        emit Locked(id);
        _tokenIds.increment();
    }

    function burn(uint256 tokenId) public onlyOwner {
        _burn(tokenId);
    }

    function locked(uint256 tokenId) public view returns (bool) {
        return lock[tokenId];
    }

    function unlock(uint256 tokenId) public onlyOwner {
        lock[tokenId] = false;
        emit Unlocked(tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual override {
        require(locked(tokenId) == false, "token is locked");
    }
}