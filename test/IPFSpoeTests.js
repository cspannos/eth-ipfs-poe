const IPFSpoe = artifacts.require("./IPFSpoe.sol");

contract("IPFSpoe", accounts => {
  it("...should emit an event when you send an IPFS address.", async () => {
    const ipfsInbox = await IPFSpoe.deployed();

    eventEmitted = false
    var event = ipfsInbox.ipfsSent()
        await event.watch((err, res) => {
            eventEmitted = true
        })

    await ipfsInbox.sendIPFS(accounts[1], "SampleAddress", { from: accounts[0] });

    assert.equal(eventEmitted, true, "Sending an IPFS request does not emit an event.");
  });
});
