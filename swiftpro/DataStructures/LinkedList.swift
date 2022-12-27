//
//  LinkedList.swift
//  swiftpro
//
//  Created by Adarsh Sudarsanan on 27/12/22.
//

// MARK: - Node for the DoublyLinkedList

class Node<T> {
    var value: T
    var prev: Node?
    weak var next: Node?
    
    init(value: T) {
        self.value = value
    }
    
}

// MARK: - Doubly Linked List

class DLinkedList<T> {
    
    var head: Node<T>?
    
    var last: Node<T>? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        
        return node
    }
    
    // Return the count of the DLinkedList.
    var count: Int {
        guard var node = head else {
            return 0
        }
        
        var length:Int = 0
        while let next = node.next {
            node = next
            length += 1
        }
        
        return length
    }
    
    public func appendFront(element: T) {
        
        // Creating an Node of the element.
        let newNode = Node(value: element)
        
        guard let head = head else {
            self.head = newNode
            return
        }
        
        newNode.next = head
        head.prev = newNode
        
        self.head = newNode
    }
    
    public func appendBack(element: T) {
        
        // Creating an Node of the element.
        let newNode = Node(value: element)
        
        guard let last = self.last else {
            self.head = newNode
            return
        }
        
        last.next = newNode
        newNode.prev = last
        newNode.next = self.head
    }
    
}


