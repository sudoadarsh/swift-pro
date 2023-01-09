//
//  ASPasswordTF.swift
//  swiftpro
//
//  Created by Adarsh Sudarsanan on 06/01/23.
//

import Foundation
import UIKit

class ASPasswordTF: UITextField {
    
    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        
        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }

    
}
