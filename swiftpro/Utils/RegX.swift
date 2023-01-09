//
//  RegX.swift
//  swiftpro
//
//  Created by Adarsh Sudarsanan on 05/01/23.
//

import Foundation

struct RegX {
    
    // The password pattern.
    static private let passwordPattern =
    
    // At least 8 characters
    #"(?=.{8,})"# +
    
    // At least one capital letter
    #"(?=.*[A-Z])"# +
    
    // At least one lowercase letter
    #"(?=.*[a-z])"# +
    
    // At least one digit
    #"(?=.*\d)"# +
    
    // At least one special character
    #"(?=.*[ !$%&?._-])"#
    
    static let passwordRegex = try! NSRegularExpression(
        pattern: passwordPattern,
        options: []
    )
}
