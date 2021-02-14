// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract DigitalArt is ERC721 {
  string private _name;
  string private _symbol;

  constructor (string memory name, string memory symbol) ERC721(_name, _symbol) public{
    _name = name;
    _symbol = symbol;
  }

  enum SoldStatus {FOR_SALE, SOLD}
  Art[] public arts;
  uint256 private pendingArtCount;
  mapping(uint256 => ArtTxn[] ) private artTxns;

  event LogArtSold(uint _tokenId, string _title, sting _authorName, uint256 _price, address _author, address _currentOwner, address _buyer);
  event LogArtTokenCreation(uint _tokenId, string _title, string _category, string authorName, uint256 _price, address _author, address _currentOwner);
  event LogArtResell(uint _tokenId, uint _status, uint256 _price);


  struct Art{
    uint256 id;
    string title;
    string description;
    uint256 price;
    string date;
    string authorName;
    address payable author;
    address payable owner;
    SoldStatus status;
    string image;
  }

  struct ArtTxn{
    uint256 id;
    uint256 price;
    address seller;
    address buyer;
    uint txnDate;
    uint status;
  }


}
