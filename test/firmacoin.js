const FirmaCoin = artifacts.require("FirmaCoin");

contract('FirmaCoin', (accounts) => {
  it('should put 10000 FirmaCoin in the first account', async () => {
    const firmaCoinInstance = await FirmaCoin.deployed();
    const balance = await firmaCoinInstance.getBalance.call(accounts[0]);

    assert.equal(balance.valueOf(), 10000, "10000 wasn't in the first account");
  });
  it('should call a function that depends on a linked library', async () => {
    const firmaCoinInstance = await FirmaCoin.deployed();
    const firmaCoinBalance = (await firmaCoinInstance.getBalance.call(accounts[0])).toNumber();
    const firmaCoinEthBalance = (await firmaCoinInstance.getBalanceInEth.call(accounts[0])).toNumber();

    assert.equal(firmaCoinEthBalance, 2 * firmaCoinBalance, 'Library function returned unexpected function, linkage may be broken');
  });
  it('should send coin correctly', async () => {
    const firmaCoinInstance = await FirmaCoin.deployed();

    // Setup 2 accounts.
    const accountOne = accounts[0];
    const accountTwo = accounts[1];

    // Get initial balances of first and second account.
    const accountOneStartingBalance = (await firmaCoinInstance.getBalance.call(accountOne)).toNumber();
    const accountTwoStartingBalance = (await firmaCoinInstance.getBalance.call(accountTwo)).toNumber();

    // Make transaction from first account to second.
    const amount = 10;
    await firmaCoinInstance.sendCoin(accountTwo, amount, { from: accountOne });

    // Get balances of first and second account after the transactions.
    const accountOneEndingBalance = (await firmaCoinInstance.getBalance.call(accountOne)).toNumber();
    const accountTwoEndingBalance = (await firmaCoinInstance.getBalance.call(accountTwo)).toNumber();

    assert.equal(accountOneEndingBalance, accountOneStartingBalance - amount, "Amount wasn't correctly taken from the sender");
    assert.equal(accountTwoEndingBalance, accountTwoStartingBalance + amount, "Amount wasn't correctly sent to the receiver");
  });
});
