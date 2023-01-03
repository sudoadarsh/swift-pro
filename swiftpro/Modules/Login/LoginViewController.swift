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
 */

class LoginViewController: UIViewController {
    
    // MARK: Class properties.
    private lazy var appLogo: UIImageView = UIImageView()
    private lazy var usernameTF: UITextField = UITextField()
    private lazy var passwordTF: UITextField = UITextField()
    
    // MARK: - App life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The background color.
        view.backgroundColor = ColorConstants.backgroundColor

        setupUI()
    }
    
    // MARK: - IB Actions.
    
    // MARK: - Class methods.
    
    private func setupUI() {
        
        // 1. Setup the app Logo.
        self.setupAppLogo()
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
    
    private func commonTFSetup(_ sender: UITextField, hint: String) {
        sender.placeholder = hint
        sender.beautify()
    }
    
    

}
