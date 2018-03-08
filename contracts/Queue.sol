pragma solidity ^0.4.15;

/**
 * @title Queue
 * @dev Data structure contract used in `Crowdsale.sol`
 * Allows buyers to line up on a first-in-first-out basis
 * See this example: http://interactivepython.org/courselib/static/pythonds/BasicDS/ImplementingaQueueinPython.html
 */

contract Queue {

// TODO 
// We need to figure out how to make it so that people only buy if there is someone behind them in line 
// Does this stem from the CrowdSale Contract or from Queue? 

/* State variables */

	/** Keep track of where in the Queue we are. */
	uint _counter;

	/** Array resizing factor. */
	uint MAX_RESIZE = 2;

	/** The number of people waiting in the queue. */
	uint8 _numCustomers;

	/** Initial size of the array. */
	uint8 size = 5;

	/** Array base of the queue (circular array). */
	address[5] _addrQueue;
	// YOUR CODE HERE


	/** Keep track of the next person in the array */
	uint8 _firstPointer;

	/** Keep track of the insertion point into the array. */
	uint8 _insertionPoint;

	/** Mapping off user addresses to time inserted. */
	mapping (address => uint256) _times; 
	
	/* Add events */
	event EjectUser(address userPastTimeLimit);
	// YOUR CODE HERE

	/** Constructor */
	function Queue() public {
		// look into how to declare this.
		// MODIFIED
		_numCustomers = 0;
		_counter = 0;
		_firstPointer = 0;
		_insertionPoint = 0;

	}

	/* Returns the number of people waiting in line */
	function qsize() public constant returns(uint8) {
		// YOUR CODE HERE
		// MODIFIED
		return _numCustomers;
	}

	/* Returns whether the queue is empty or not */
	function empty() constant returns(bool) {
		// YOUR CODE HERE
		return _numCustomers == 0;
	}

	/* Returns the address of the person in the front of the queue */
	function getFirst() public view returns(address) {
		// YOUR CODE HERE
		return _addrQueue[_firstPointer];
	}

	/* Allows `msg.sender` to check their position in the queue */
	function checkPlace() public view returns(uint8) {
		// YOUR CODE HERE
		address sender = msg.sender;
		uint8 count = 1;
		for (uint8 i = _firstPointer; i < _insertionPoint; i = (i + 1 + size) % size) {
			if (_addrQueue[i] == sender) {
				return count;
			}
			count += 1;
		}
		return 0;
	}

	/* Allows anyone to expel the first person in line if their time
	 * limit is up
	 */
	function checkTime() {
		// YOUR CODE HERE
<<<<<<< HEAD
		// TODO
		// this is going to be tough. How do we approach this?
		// we need to add the end time here
		uint256 endTime = 0;
		address checker = msg.sender; 
		uint8 dummyPointer = _firstPointer; 
		address runner = _addrQueue[dummyPointer];
		while (runner != checker) {
			uint256 runnerTime = _times[runner];
			if (runner != 0 && runnerTime > endTime) {
				_addrQueue[_firstPointer] = 0;
				_times[runner] = 0;
				_firstPointer = (_firstPointer + 1 + size) % size;
			}
			runner = _addrQueue[++dummyPointer];
		}
=======
		// this is going to be tough. How do we approach this?
>>>>>>> 10b2cb2b975b3818fe2285ae146837ed0c9a091a
	}

	/* Removes the first person in line; either when their time is up or when
	 * they are done with their purchase
	 */
	function dequeue() {
		// YOUR CODE HERE
<<<<<<< HEAD
		uint8 temp = _firstPointer; 
		_times[_addrQueue[temp]] = 0;
		_firstPointer = (_firstPointer + size + 1) % size;
		_addrQueue[temp] = 0;
		_numCustomers -= 1;
		// TODO INCORPORATE TIME STAMPS
=======
		uint8 temp = _firstPointer;
		_firstPointer = (_firstPointer + size) % size;
		_addrQueue[temp] = 0;
		_numCustomers -= 1;
>>>>>>> 10b2cb2b975b3818fe2285ae146837ed0c9a091a
	}

	/* Places `addr` in the first empty position in the queue */
	function enqueue(address addr) {
		// YOUR CODE HERE
		if (_numCustomers < size) {
			_times[addr] = now + (5 days);
			_addrQueue[_insertionPoint] = addr;
			_insertionPoint = (_insertionPoint + 1 + size) % size;
			return;
		} else {
			return;
		}
	}
}
