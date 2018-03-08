'use strict'

/* Add the dependencies you're testing */
const Crowdsale = artifacts.require('./Crowdsale.sol')
// YOUR CODE HERE

contract('CrowdsaleTest', function(accounts) {
	/* Define your constant variables and instantiate constantly changing
	 * ones
	 */
	const args = { _initialSupply: 1000000000 }
	let crowdSale
	let token

	/* Do something before every `describe` method */
	beforeEach(async () => {
		// YOUR CODE HERE
		crowdSale = await Crowdsale.new(_initialSupply, 'TestToken', 'TTK', 2)
	})

	/* Group test cases together
	 * Make sure to provide descriptive strings for method arguements and
	 * assert statements
	 */
	describe('~Crowdsale Works~', () => {
		it('deploys a Token', async () => {
			assert.ok(Token.options.address)
		})
		// YOUR CODE HERE
	})

	describe('Your string here', function() {
		// YOUR CODE HERE
	})
})
