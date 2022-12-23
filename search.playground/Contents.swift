// Search.

// Linear search. That returns the index of an element from an array.
func linearSearch(array: [Int], value: Int) -> Int? {
    for i in 0...array.count {
        if (
            array[i] == value
        ) {
            return i
        }
    }
    
    return nil
}

// Binary search. The iterative method.
func binarySearch<T: Comparable>(array: [T], value: T) -> Int? {
    
    var lowerBound: Int = 0
    var upperBound: Int = array.count
    
    while lowerBound < upperBound {
        let midIndex: Int = lowerBound + (upperBound - lowerBound)/2
        
        if array[midIndex] == value {
            return midIndex
        } else if array[midIndex] < value {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    
    return nil
    
}

let result = binarySearch(array: [1,2,3,4,5], value: 4)

