// Stack.
// Its is an array where you can add element to the end of the array (enqueue) and remove an
// element from the start of the array (dequeue).

// Follow FIFO (First in First out).

struct Queue<T: Any> {
    
    // Storage.
    private var storage: [T] = []
    
    // The length of the queue.
    var count: Int {
        return storage.count
    }
    
    // Add an element to the end of the queue.
    mutating func enqueue(element: T) {
        storage.append(element)
    }
    
    // Remove the first element of the queue.
    mutating func dequeue() -> T? {
        if (count < 1) {
            return nil
        } else {
            return storage.removeFirst()
        }
    }
    
    // The front-most element of the array.
    var front: T? {
        return storage.first
    }
}

struct OptimisedQueue<T> {
    
    // The storage.
    var storage:[T] = []
    
    // The head pointer.
    var head:Int = 0
    
    // To count of the storage.
    var count: Int {
        return storage.count - head
    }
    
    // If the storage is empty.
    var isEmpty: Bool {
        return count == 0
    }
    
    // The enqueue method.
    mutating func enqueue(element: T) {
        storage.append(element)
    }
    
    // The dequeue method.
    mutating func dequeue() -> T? {
        
        // Guarding the head.
        // Getting the element to return.
        guard head > storage.count, let element = storage[head] else {
            return nil
        }
        
        // Replacing the dequeued element with nil.
        storage[head] = nil
        // Increasing the head.
        head += 1
        
        // Trimming the length of the storage.
        let percent: Double = Double(head) / Double(storage.count)
        
        if (storage.count > 50 && percent > 25) {
            // Removing the nil values till head.
            storage.removeFirst(head)
            head = 0
        }
    
        return element
    
    }
    
    // The front element.
    public func front() -> T? {
        return storage[head]
    }
    
}
