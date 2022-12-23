// Stack in swift.
// Value type Stack object.

// Stack functionalities.
/// 1. Push to add element on top of the stack
/// 2. Pop to remove element from the top
/// 3. Peek the element at the top without popping it

// Follows Last in first out (LIFO).

struct Stack<T: Any> {
    
    // The stack storage.
    private var storage: [T] = []
    
    // The length of the stack.
    var count: Int {
        return storage.count
    }
    
    // To push an element to the top of the stack.
    /// 💡 [mutuating] is used with a function that will modify a property within its enclosing value.
    mutating func push(element: T) {
        storage.append(element)
    }
    
    // To remove an element from the top of the stack.
    mutating func pop() -> T? {
        storage.popLast()
    }
    
    // The top element of the stack.
    var top: T? {
        return storage.last
    }
    
}

///💡 Adding an element to the end of the array is always an O(1) operation since it requires no elements of the array to be shifted in the memory.
///
