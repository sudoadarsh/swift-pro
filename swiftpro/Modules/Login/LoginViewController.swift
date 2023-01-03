//
//  LoginViewController.swift
//  swiftpro
//
//  Created by Adarsh Sudarsanan on 03/01/23.
//

import UIKit

/**
 This screen is build programatically.
 Learning outcomes:
    1. Layout constraints
    2.  Adding height and width to [UIImageView]
    3. Adding subviews in a stack programatically
 */

class LoginViewController: UIViewController {
    
    // MARK: Class properties.
    
    private lazy var appLogo: UIImageView = UIImageView()
    private lazy var appName: UILabel = UILabel()
    private lazy var loginButton: UIButton = UIButton()
    private lazy var usernameTF: UITextField = UITextField()
    private lazy var passwordTF: UITextField = UITextField()
    private lazy var stackView = UIStackView()
    
    // MARK: - App life cycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The background color.
        view.backgroundColor = ColorConstants.backgroundColor
        
        setupUI()
    }
        
    
    // MARK: - Class methods.
    
    private func setupUI() {
        
        // 1. Setup the app Logo.
        self.setupAppLogo()
        
        // 2. Setup the stack content.
        self.stackContentSetup()
    }
    
    private func setupAppLogo() {
        
        // Create a sub-view, the app logo will be centered to this view.
        let subView = UIView()
        self.view.addSubview(subView)
        subView.attachToTop(self.view)
        subView.halfOfScreen(self.view)
        
        let image: UIImage? = UIImage(named: AssetConstants.logo)
        self.appLogo.image = image
        
        subView.addSubview(self.appLogo)
        self.appLogo.centerInSuperview(subView)
        self.appLogo.heightAnchor.constraint(equalToConstant: 130).isActive = true
        self.appLogo.widthAnchor.constraint(equalToConstant: 130).isActive = true
    }
    
    private func commonTFSetup(_ sender: UITextField, hint: String) -> UITextField {
        sender.placeholder = hint
        sender.backgroundColor = ColorConstants.backgroundColor
        sender.tfBeautify()
        
        return sender
    }
    
    private func appNameSetup(_ sender: UILabel) -> UILabel {
        sender.text = StringConstants.appDisplayName
        sender.textColor = .white
        sender.font = sender.font.withSize(24.0)
        sender.textAlignment = NSTextAlignment.center
        
        return sender
    }
    
    private func loginButtonSetup(_ sender: UIButton) -> UIButton {
        sender.backgroundColor = ColorConstants.backgroundColor
        sender.setTitle(StringConstants.login, for: .normal)
        sender.setTitleColor(ColorConstants.primaryColor, for: .normal)
        sender.buttonBeautify()
        
        return sender
    }
    
    private func stackContentSetup() {
        let subView = UIView()
        
        subView.backgroundColor = ColorConstants.primaryColor
        self.view.addSubview(subView)
        
        subView.halfOfScreen(self.view)
        subView.attachToBottom(self.view, bottom: 24, trailing: 8, leading: 8)
        subView.beautify(radius: 30.0)
        
        subView.addSubview(stackView)
        stackView.attachToTop(subView)
                
        // Start adding elements into the stack view.
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 8.0
        
        self.addToStack(widgets: [appNameSetup(appName), commonTFSetup(usernameTF, hint: StringConstants.username), commonTFSetup(passwordTF, hint: StringConstants.password), loginButtonSetup(loginButton)])
        
        
    }
    
    private func addToStack(widgets: [UIView]) {
        for widget in widgets {
            stackView.addArrangedSubview(widget)
        }
    }
    
}
