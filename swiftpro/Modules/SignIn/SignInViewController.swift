//
//  SignInViewController.swift
//  swiftpro
//
//  Created by Adarsh Sudarsanan on 10/01/23.
//

import UIKit

class SignInViewController: UIViewController {
    
    private lazy var userDp: UIImageView = UIImageView()
    private lazy var dpNote: UILabel = UILabel()
    
    // The text fields.
    private lazy var usernameTF: UITextField = UITextField()
    private lazy var passwordTF: UITextField = UITextField()
    private lazy var emailTF: UITextField = UITextField()
    
    // The buttons.
    private lazy var signInButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the back button.
        self.navigationItem.hidesBackButton = true
        
        view.backgroundColor = ColorConstants.backgroundColor
        
        setupUI()

    }
    
    // MARK: - Class methods.
    
    private func setupUI() {
        
        // 1. Setup the user DP.
        userDpSetup()
        
        // 2. Setup the dp note.
        dpNoteSetup()
        
        
    }
    
    private func userDpSetup() {
        
        // Sub View to attach the User DP.
        
        let subView = UIView()
        self.view.addSubview(subView)
        subView.attachToTop(self.view)
        subView.halfOfScreen(self.view)
        
        // Get the default profile image.
        
        var image: UIImage? = UIImage()
        image = UIImage(systemName: AssetConstants.defaultProfile)
        
        userDp.image = image
        userDp.tintColor = ColorConstants.primaryColor
        
        subView.addSubview(userDp)
        subView.addSubview(dpNote)
        
        userDp.centerInSuperview(subView)
        
        userDp.heightAnchor.constraint(equalToConstant: 130).isActive = true
        userDp.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        dpNote.translatesAutoresizingMaskIntoConstraints = false
        dpNote.topAnchor.constraint(equalTo: userDp.bottomAnchor, constant: 10).isActive = true
        dpNote.centerXAnchor.constraint(equalTo: subView.centerXAnchor).isActive = true
        
    }
    
    private func dpNoteSetup() {
        dpNote.text = StringConstants.dpNote
        dpNote.font = dpNote.font.withSize(18)
        dpNote.textColor = .black
    }
    
}
