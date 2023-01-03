//
//  Extensions.swift
//  swiftpro
//
//  Created by Adarsh Sudarsanan on 29/12/22.
//

import Foundation
import UIKit

// MARK: - UIButton extension.
extension UIButton {
    func buttonBeautify() {
        self.layer.borderColor = self.backgroundColor?.cgColor
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

// MARK: - UITextField extension.
extension UITextField {
    
    func tfBeautify() {
        
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.textColor = UIColor.black
        
        self.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 8)
    }
}

// MARK: - Constraints Extension.
extension UIView {
    
    // Beautify.
    func beautify(radius: Double) {
        self.layer.cornerRadius = radius
    }
        
    // Center a UI element in the center of a View.
    func centerInSuperview(_ sender: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.centerYAnchor.constraint(equalTo: sender.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: sender.centerXAnchor).isActive = true
    }
    
    // Set the height of the UI element to the half of the view.
    func halfOfScreen(_ sender: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.heightAnchor.constraint(equalToConstant: sender.frame.size.height / 2).isActive = true
    }
    
    // Attach the UI element to the top of the screen.
    func attachToTop(_ sender: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.topAnchor.constraint(equalTo: sender.topAnchor, constant: 8).isActive = true
        self.trailingAnchor.constraint(equalTo: sender.trailingAnchor, constant: -8.0).isActive = true
        self.leadingAnchor.constraint(equalTo: sender.leadingAnchor, constant: 8.0).isActive = true
    }
    
    func attachToTop(_ sender: UIView, top: Double, trailing: Double, leading: Double) {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.topAnchor.constraint(equalTo: sender.topAnchor, constant: top).isActive = true
        self.trailingAnchor.constraint(equalTo: sender.trailingAnchor, constant: trailing).isActive = true
        self.leadingAnchor.constraint(equalTo: sender.leadingAnchor, constant: leading).isActive = true
    }
    
    
    // Attach the UI element to the bottom of the screen.
    func attachToBottom(_ sender: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.bottomAnchor.constraint(equalTo: sender.bottomAnchor, constant: -8).isActive = true
        self.trailingAnchor.constraint(equalTo: sender.trailingAnchor, constant: -8.0).isActive = true
        self.leadingAnchor.constraint(equalTo: sender.leadingAnchor, constant: 8.0).isActive = true
    }
    
    func attachToBottom(_ sender: UIView, bottom: Double, trailing: Double, leading: Double) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.bottomAnchor.constraint(equalTo: sender.bottomAnchor, constant: -bottom).isActive = true
        self.trailingAnchor.constraint(equalTo: sender.trailingAnchor, constant: -trailing).isActive = true
        self.leadingAnchor.constraint(equalTo: sender.leadingAnchor, constant: leading).isActive = true
    }
    
    func attachAround(_ sender: UIView, bottom: Double, trailing: Double, leading: Double, top: Double) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.topAnchor.constraint(equalTo: sender.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: sender.bottomAnchor, constant: -bottom).isActive = true
        self.trailingAnchor.constraint(equalTo: sender.trailingAnchor, constant: -trailing).isActive = true
        self.leadingAnchor.constraint(equalTo: sender.leadingAnchor, constant: leading).isActive = true
    }
    
    func attachAround(_ sender: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: sender.topAnchor, constant: 8).isActive = true
        self.bottomAnchor.constraint(equalTo: sender.bottomAnchor, constant: -8).isActive = true
        self.trailingAnchor.constraint(equalTo: sender.trailingAnchor, constant: -8.0).isActive = true
        self.leadingAnchor.constraint(equalTo: sender.leadingAnchor, constant: 8.0).isActive = true
    }
    
    
}
