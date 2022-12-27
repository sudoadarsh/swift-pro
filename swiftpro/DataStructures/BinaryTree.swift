//
//  BinaryTree.swift
//  swiftpro
//
//  Created by Adarsh Sudarsanan on 27/12/22.
//

// Binary tree is a tree where each node can children not greater than 2.
// Child nodes are usually called the left and right nodes.

// The [indirect] keyword is used if the enum refers to itself.
public indirect enum BinaryTree<T> {
    case node(leftChild: BinaryTree<T>, value:T, rightChild: BinaryTree<T>)
    case empty
}

extension BinaryTree {
    
    // Transverse in order or Depth-first.
    public func transverseInOrder(completion: (T) -> Void) {
        if case let .node(leftChild: leftChild, value: value, rightChild: rightChild) = self {
            leftChild.transverseInOrder(completion: completion)
            completion(value)
            rightChild.transverseInOrder(completion: completion)
        }
    }
    
    // Pre-order.
    public func transversePreOrder(completion: (T) -> Void) {
        if case let .node(leftChild: leftChild, value: value, rightChild: rightChild) = self {
            completion(value)
            leftChild.transversePreOrder(completion: completion)
            rightChild.transversePreOrder(completion: completion)
        }
    }
    
    // Post-order similar to Pre-Order.
}
