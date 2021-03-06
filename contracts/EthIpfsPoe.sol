pragma solidity ^0.5.0;

contract EthIpfsPoe {

  // Maps - proofs need wiring up
  mapping (bytes32 => bool) private proofs;
  mapping (address => string) ipfsInbox;

  // Events
  event ipfsSent(string _ipfsHash, address _address);
  event inboxResponse(string response);

  // Modifier: checks if inbox is full or not
  modifier notFull (string memory _string) {
  bytes
  memory
  stringTest = bytes(_string);
  require (stringTest.length == 0); _
  ;}

  // An empty constructor that creates an instance of the contract
  constructor() public {}

  // store a proof of existence in the contract state - wire up into React state
  function storeProof(bytes32 proof) internal {
    proofs[proof] = true;
  }

  // calculate and store the proof for a file - wire up into React state
  function notarize(string calldata file) external {
    bytes32 proof = proofFor(file);
    storeProof(proof);
  }

  // helper function to get a document's sha256
  function proofFor(string memory file) pure public returns (bytes32) {
    return sha256(abi.encodePacked(file));
  }

  // check if a file has been notarized - wire up in React????
  function checkfile(string memory file) public view returns (bool) {
    bytes32 proof = proofFor(file);
    return hasProof(proof);
  }

  // A function that takes in the receiver's address and the
  // IPFS address. Places the IPFS address in the receiver's
  // inbox.
  function sendIPFS(address _address, string memory _ipfsHash)
      notFull(ipfsInbox[_address])
      public
  {
     ipfsInbox[_address] = _ipfsHash;
     emit ipfsSent(_ipfsHash, _address);
  }

  // returns true if proof is stored - needs wiring up in React
  function hasProof(bytes32 proof) internal view returns(bool) {
    return proofs[proof];
  }

  // A function that checks your inbox and empties it afterwards.
  // Returns an address if there is one, or "Empty Inbox"
  function checkInbox()
      public
  {
      string memory ipfs_hash = ipfsInbox[msg.sender];
      if(bytes(ipfs_hash).length == 0) {
          emit inboxResponse("Empty Inbox");
      } else {
          ipfsInbox[msg.sender] = "";
          emit inboxResponse(ipfs_hash);
      }
  }

}
