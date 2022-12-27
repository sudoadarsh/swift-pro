//
//  Tree.swift
//  swiftpro
//
//  Created by Adarsh Sudarsanan on 27/12/22.
//

// Tree data structure.
// A tree consists of nodes, and these nodes are linked to one another.

// Node can have on parent node and various child nodes.
// Node without a parent node = Root node.
// Node without a child node = Leaf node.

// Pointers in a Tree does not form a circle otherwise it will be a Graph.

// A general purpose tree with any number of children.

// The tree node.
class TreeNode<T> {
    var value: T
    
    var parent: TreeNode?
    var children:[TreeNode<T>] = []
    
    init(value: T) {
        self.value = value
    }
    
    // To add a child.
    func addChild(element: T) {
        
        // Converting the element to a node.
        let node: TreeNode<T> = TreeNode(value: element)
        
        children.append(node)
        node.parent = self
    }
}

extension TreeNode where T: Equatable {
    func search(_ value: T) -> TreeNode? {
        
        if value == self.value {
            return self
        }
        
        for child in children {
            if let found = child.search(value) {
                return found
            }
        }
        
        return nil
    }
}
