// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract DigitalArt is ERC721 {

  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  string private _name;
  string private _symbol;

  enum SoldStatus {FOR_SALE, SOLD}
  Art[] public arts;
  uint256 private pendingArtCount;
  mapping(uint256 => ArtTxn[] ) private artTxns;

  event LogArtSold(uint _tokenId, string _title, string _authorName, uint256 _price, address _author, address _currentOwner, address _buyer);
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

  constructor (string memory name, string memory symbol) ERC721(_name, _symbol) public{
    _name = name;
    _symbol = symbol;
  }

  function createTokenAndSellArt(string memory _title, string memory _descriptio, string memory _date,
    string memory _authorName, uint256 _price, string memory _image) public returns (uint256) {

    require(bytes(_title).length > 0, 'The title cannot be empty');
    require(bytes(_date).length > 0, 'The date cannot be empty');
    require(bytes(_description).length > 0, 'The description cannot be empty');
    require(bytes(_image).length > 0, 'The image cannot be empty');

    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();

    Art memory _art = Art({
    id: newItemId,
    title: _title,
    description: _description,
    price: _price,
    date: _date,
    authorName: _authorName,
    author: msg.sender,
    owner: msg.sender,
    status: SoldStatus.FOR_SALE,
    image: _image

    });

    arts.push(_art);
    _mint(msg.sender, newItemId);
    pendingArtCount++;
    emit LogArtSold(_tokenId,_title,  _authorName,_price, _author,_current_owner,msg.sender);
    return newItemId;

  }


}
