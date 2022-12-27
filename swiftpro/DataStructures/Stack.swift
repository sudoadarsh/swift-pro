//
//  Stack.swift
//  swiftpro
//
//  Created by Adarsh Sudarsanan on 27/12/22.
//

// Follows the LIFO principle.
// Push and pop are O(1) operation.

struct Stack<T> {
    
    // The storage.
    private var storage:[T] = []
    
    // The count of the storage.
    var count: Int {
        return storage.count
    }
    
    // Push.
    mutating func push(element: T) {
        storage.append(element)
    }
    
    // Pop.
    mutating func pop() -> T? {
        
        return storage.popLast()
        
    }
    
    // Peek the top element without removing it.
    var top: T? {
        
        return storage.last
        
    }
    
    
}
