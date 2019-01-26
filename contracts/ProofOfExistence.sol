pragma solidity ^0.4.23;

import "../installed_contracts/zeppelin/contracts/math/SafeMath.sol";


contract ProofOfExistence {

  using SafeMath for uint;

  // Structs
  struct File {
    address   creator;
    string    fileHash;
    uint      timestamp;
  }

   // Other Constants
  uint public currentFileIndex;

  // mapping of file index to file
  // FILE INDEX || FILE
  mapping (uint => File) public fileMap;

  // mapping of user addresses to an array of files
  // ADDRESS USER || Array of file indices
  mapping (address => uint[]) public userMap;

  // mapping of file hash to its file index
  // not public because public accessor of dynamically sized mapping is not yet built
  // STRING FILEHASH || UINT FILE INDEX
  mapping (string => uint) fileHashMap;

  // Events
  event FileRegistered(string fileHash, uint indexed fileIndex);

  address public owner;

  modifier onlyOwner() {
        require(msg.sender == owner);
        _;
  }

  constructor() public {
    currentFileIndex = 1;
    owner = msg.sender;
  }

  /** @dev Registers an IPFS file hash to contract.
    * @param _fileHash the IPFS file hash to register.
    * @return boolean if successful transaction.
    */
  function registerFile(string _fileHash) public payable returns (bool success) {
    // The same file cannot be registered twice
    require(fileHashMap[_fileHash] == 0);

    fileMap[currentFileIndex] = File(msg.sender, _fileHash, now);
    userMap[msg.sender].push(currentFileIndex);
    fileHashMap[_fileHash] = currentFileIndex;
    currentFileIndex = currentFileIndex.add(1);

    emit FileRegistered(_fileHash, currentFileIndex.sub(1));
    return true;
  }

  /** @dev Returns all file info given file index in fileMap.
    * @param _index - index of registered file in fileMap.
    * @return creator The address of file creator.
    * @return fileHash The file IPFS hash.
    * @return timestamp The timestamp of file registry saved in blockchain.
    */
  function getFile(uint _index) public view returns (
    address   creator,
    string    fileHash,
    uint      timestamp
  ) {
    require(_index > 0);
    File memory f = fileMap[_index];
    return (f.creator, f.fileHash, f.timestamp);
  }
  /** @dev Shortcut function to check if a fileHash exists in registry.
    * @param _fileHash the IPFS file hash to register.
    * @return boolean if file exists.
    */
  function checkFileExists(string _fileHash) public view returns (bool fileExists) {
    fileExists = fileHashMap[_fileHash] > 0;
  }

  function getUserMap(address _user) public view returns ( uint[] index) {
     return userMap[_user];
  }

}
