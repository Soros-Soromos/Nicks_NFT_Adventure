// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract nftContract{
    uint public nftCount = 0;
    uint public dead = 0;
    mapping (uint => NFT) public nfts;
    struct NFT {
        address investorAddress;
        uint id;
        string Placeholder;
        uint createdTime;
        uint remainingTime;
    }
    // should be using block.number instead of block.timestamp
    
   function createNFT (string memory _placeholder, uint _remainingTime) public returns(uint){
       nftCount++;
       nfts[nftCount] = NFT(msg.sender, nftCount, _placeholder, block.timestamp, _remainingTime);
       return nftCount;
   }
   function checkRemainingTime (uint _id) public {
        if (block.timestamp >= nfts[_id].createdTime + nfts[_id].remainingTime){
           deleteNft(_id);
       }
        else {viewRemainingTime(_id);}
   }
   function viewRemainingTime(uint _id) public view returns (uint){
       return nfts[_id].remainingTime + nfts[_id].createdTime - block.timestamp;
   }
   function deleteNft(uint _id) internal {
       delete nfts[_id];
   }
   function viewNft (uint _id) public view returns(string memory){
       return nfts[_id].Placeholder;
   }
   function addTime (uint _id) public payable returns (uint){
       nfts[_id].remainingTime = nfts[_id].remainingTime + msg.value;
       return nfts[_id].remainingTime;
   }
}
