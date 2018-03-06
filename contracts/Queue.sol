pragma solidity ^0.4.15;

/**
 * @title Queue
 * @dev Data structure contract used in `Crowdsale.sol`
 * Allows buyers to line up on a first-in-first-out basis
 * See this example: http://interactivepython.org/courselib/static/pythonds/BasicDS/ImplementingaQueueinPython.html
 */

contract Queue {

/* State variables */

	/** Keep track of where in the Queue we are. */
	uint counter; 

	/** Array base of the queue. */
	address[] addrQueue; 

	/** Array resizing factor. */
	uint MAX_RESIZE = 2;
	
	/** The number of people waiting in the queue. */
	uint8 numCustomers;

	/** Initial size of the array. */
	uint8 size = 5;

	// YOUR CODE HERE

	/* Add events */
	// YOUR CODE HERE

	/** Constructor */
	function Queue() public {
		// look into how to declare this.
		addrQueue = new address[](size);
		numCustomers = 0; 
		counter = 0;
	}

	/* Returns the number of people waiting in line */
	function qsize() public constant returns(uint8) {
		// YOUR CODE HERE
		// MODIFIED
		return numCustomers;
	}

	/* Returns whether the queue is empty or not */
	function empty() constant returns(bool) {
		// YOUR CODE HERE
		return numCustomers == 0;
	}
	
	/* Returns the address of the person in the front of the queue */
	function getFirst() constant returns(address) {
		// YOUR CODE HERE
		return addrQueue[counter];
	}
	
	/* Allows `msg.sender` to check their position in the queue */
	function checkPlace() public constant returns(uint8) {
		// YOUR CODE HERE
		address addr = msg.sender;
		uint8 inLine = 0;
		for (uint i = counter; i < size; i++) {
			address curr = addrQueue[i];
			if (addr == curr) {
				return inLine;
			} else {
				inLine += 1;
			}
		}
		return 0;
	}
	
	/* Allows anyone to expel the first person in line if their time
	 * limit is up
	 */
	function checkTime() {
		// YOUR CODE HERE
		// this is going to be tough. How do we approach this? 
	}
	
	/* Removes the first person in line; either when their time is up or when
	 * they are done with their purchase
	 */
	function dequeue() public (address) {
		// YOUR CODE HERE
		counter += 1;
		return addrQueue[counter - 1];
	}

	/* Places `addr` in the first empty position in the queue */
	function enqueue(address addr) {
		// YOUR CODE HERE
		counter += 1;
	}
}
