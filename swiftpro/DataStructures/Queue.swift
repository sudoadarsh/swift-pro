//
//  Queue.swift
//  swiftpro
//
//  Created by Adarsh Sudarsanan on 27/12/22.
//

// MARK: - Simple Queue.

struct Queue<T> {
    
    // The storage.
    private var storage: [T] = []
    
    // The count of the storage.
    var count: Int {
        return storage.count
    }
    
    // Boolean to check if the storage is empty.
    var isEmpty: Bool {
        return storage.isEmpty
    }
    
    // Enqueue.
    mutating func enqueue(element: T) {
        storage.append(element)
    }
    
    // Dequeue.
    mutating func dequeue() -> T? {
        if !isEmpty {
            return storage.removeFirst()
        }
        return nil
    }
    
    // The front element.
    var front: T? {
        return storage.first
    }
}

// MARK: The optimised Queue.

struct OptimisedQueue<T> {
    
    // The storage.
    private var storage: [T?] = []
    
    // The head, a pointer to the first element.
    private var head: Int = 0
    
    // The front element.
    var front: T? {
        return storage[head]
    }
    
    // The count of the storage.
    var count: Int {
        return storage.count - head
    }
    
    // Enqueue.
    mutating func enqueue(element: T) {
        storage.append(element)
    }
    
    // Dequeue.
    mutating func dequeue() -> T? {
        
        guard head < storage.count, let front = storage[head] else {
            return nil
        }
        
        storage[head] = nil
        head += 1
        
        // Trimming the storage.
        let percent = Double(storage.count) / Double(head)
        
        if percent > 0.25 && storage.count > 50 {
            storage.removeFirst(head)
            head = 0
        }
        
        return front
    }
    
}

// MARK: - Deque (Deck) double ended queue.

struct Deque<T> {
    
    // The storage.
    private var storage:[T?] = []
    
    // The count.
    var count: Int {
        return storage.count
    }
    
    // To check if the storage is empty.
    var isEmpty: Bool {
        return storage.isEmpty
    }
    
    // Enqueue.
    mutating func enqueue(element: T) {
        storage.append(element)
    }
    
    // Enqueue at the front.
    mutating func enqueueFront(element: T) {
        storage.insert(element, at: 0)
    }
    
    // Dequeue.
    mutating func dequeue() -> T? {
        
        if !isEmpty {
            return storage.removeFirst()
        }
        
        return nil
    }
    
    // Dequeue from the back.
    mutating func dequeueBack() -> T? {
        
        if !isEmpty {
            return storage.removeLast()
        }
        
        return nil
    }
}
