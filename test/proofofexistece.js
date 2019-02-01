var ProofOfExistence = artifacts.require('./ProofOfExistence')
const crypto = require("crypto");

function sha256AsHexString(doc) {
    return "0x" + crypto.createHash("sha256").update(doc, "utf8").digest("hex");
}

contract('ProofOfExistence', function(accounts) {

    const owner = accounts[0]
    const price = web3.utils.toWei("1", "ether")

    it("should register a filehash (happy path)", async() => {
        const proofOfExistence = await ProofOfExistence.deployed()

        const fileHash = sha256AsHexString("file")
	const tx = await proofOfExistence.registerFile(fileHash)
        const exists = await proofOfExistence.checkFileExists(fileHash)

	assert.equal(exists, true, 'file does not stored')
    })
    it("should not register an existing asset (fail proof)", async() => {
        const proofOfExistence = await ProofOfExistence.deployed()

        var eventEmitted = false
        const fileHash = sha256AsHexString("fileTest")
	const tx = await proofOfExistence.registerFile(fileHash)
      
        try {
              //Same file
               
	      const tx2 = await proofOfExistence.registerFile(fileHash)
        } catch (error) {
            return;
        }
        assert(false, 'Expected Error: "VM Exception while processing transaction: revert" not received');
    })
    it("only owner (fail proof)", async() => {
        const proofOfExistence = await ProofOfExistence.deployed()
        const fileHash = "fileTest3"
	try {
	   const tx2 = await proofOfExistence.registerFile(fileHash, {from: accounts[1]})
        } catch (error) {
            return;
        }
        assert(false, 'Expected Error: "VM Exception while processing transaction: revert" not received');
    })
    it("files by user/owner (happy path)", async() => {
        const proofOfExistence = await ProofOfExistence.deployed()

        //previously has been stored two files
        const result = await proofOfExistence.getUserMap(owner)

        assert.equal(result.length, 2, 'There are more or less than two for this user')
     
    })
    it("files by user/not-owner (happy path)", async() => {
        const proofOfExistence = await ProofOfExistence.deployed()

        //it has not been stored files for the user accounts[1]
        const result = await proofOfExistence.getUserMap(accounts[1])
        assert.equal(result.length, 0, 'There are files for this user')     
    })
});
