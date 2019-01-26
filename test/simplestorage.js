var ProofOfExistence = artifacts.require('./ProofOfExistence')

contract('ProofOfExistence', function(accounts) {

    const owner = accounts[0]
    const alice = accounts[1]
    const bob = accounts[2]
    const emptyAddress = '0x0000000000000000000000000000000000000000'

    var sku
    const price = web3.toWei(1, "ether")

    it("should register an asset with the provided filehash", async() => {
        const roofOfExistence = await ProofOfExistence.deployed()

        var eventEmitted = false
        //const name = "book"
	const tx = await supplyChain.addItem(name, price, {from: alice})
	if (tx.logs[0].event === "ForSale") {
		//sku = tx.logs[0].args.sku.toString(10)
		eventEmitted = true
	}

        //const result = await supplyChain.fetchItem.call(sku)

       // assert.equal(result[0], name, 'the name of the last added item does not match the expected value')
        //assert.equal(result[2].toString(10), price, 'the price of the last added item does not match the expected value')
        //assert.equal(result[3].toString(10), 0, 'the state of the item should be "For Sale", which should be declared first in the State Enum')
        //assert.equal(result[4], alice, 'the address adding the item should be listed as the seller')
        //assert.equal(result[5], emptyAddress, 'the buyer address should be set to 0 when an item is added')
        assert.equal(eventEmitted, true, 'adding an item should emit a For Sale event')
    })
});
