/// Insertion sort.
///
func insertionSort<T: Comparable>(_ array: [T]) -> [T] {
    
    var sortedArray = array
    
    for index in 1..<sortedArray.count {
                
        var currentIndex = index
        var temp = sortedArray[currentIndex]
        
        while currentIndex > 0 && temp < sortedArray[currentIndex - 1] {
            sortedArray[currentIndex] = sortedArray[currentIndex - 1]
            currentIndex -= 1
        }
        
        sortedArray[currentIndex] = temp
        
    }
    
    return sortedArray
}
