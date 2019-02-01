pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";


contract ProofOfExistence {

  //Emergency Stop pattern
  bool isStopped = false;

  using SafeMath for uint;

  // Structs
  struct File {
    address   creator;
    string    fileHash ;
    uint      timestamp;
  }

   // Other Constants
  uint public currentFileIndex;

  // mapping of file index to file
  mapping (uint => File) public fileMap;

  // mapping of user addresses to an array of files
  mapping (address => uint[]) public userMap;

  // mapping of file hash to its file index
  mapping (string => uint) fileHashMap;

  // Events
  event FileRegistered(string fileHash, uint indexed fileIndex);

  address public owner;

  modifier onlyOwner() {
        require(msg.sender == owner);
        _;
  }

  // The same file cannot be registered twice
  modifier uniqueFile(string memory _fileHash) {
        require(fileHashMap[_fileHash] == 0);
        _;
  }

  modifier stoppedInEmergency {
      require(!isStopped);
      _;
  }

  modifier onlyWhenStopped {
      require(isStopped);
      _;
  }

  constructor() public {
    currentFileIndex = 1;
    owner = msg.sender;
  }


  function stopContract() public onlyOwner {
        isStopped = true;
  }

  function resumeContract() public onlyOwner {
        isStopped = false;
  }


  /** @dev Registers a file hash to contract.
    * @param _fileHash the file hash to register.
    * @return boolean if successful transaction.
    */
  function registerFile(string memory _fileHash) public payable onlyOwner stoppedInEmergency uniqueFile(_fileHash)  returns (bool success) {
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
    * @return fileHash The file hash.
    * @return timestamp The timestamp of file registry saved in blockchain.
    */
  function getFile(uint _index) public view returns (
    address   creator,
    string    memory fileHash,
    uint      timestamp
  ) {
    require(_index > 0);
    File memory f = fileMap[_index];
    return (f.creator, f.fileHash, f.timestamp);
  }

  /** @dev check if a fileHash exists .
    * @param _fileHash the file hash to register.
    * @return boolean if file exists.
    */
  function checkFileExists(string memory _fileHash) public view returns (bool fileExists) {
    fileExists = fileHashMap[_fileHash] > 0;
  }

  /** @dev Returns all Indexes given user.
    * @param _user - indexes of registered file in userMap.
    * @return uint[] Indexes.
    */
  function getUserMap(address _user) public view returns ( uint[] memory index) {
     return userMap[_user];
  }

  /** @dev Shortcut function to read a file's index by its hash.
    * @param _fileHash the file hash to register.
    * @return uint index.
    */
  function getFileIndexByFileHash(string memory _fileHash) public view returns (uint index) {
    return fileHashMap[_fileHash];
  }

}
