//
//  SignInViewController.swift
//  swiftpro
//
//  Created by Adarsh Sudarsanan on 10/01/23.
//

import UIKit

/// This protocol will be implemented by the [SignInViewController] and will receive inputs from [SignInPresenterDelegate].
protocol SignInViewDelegate: AnyObject {
    func updateDP(image: UIImage)
    func displayError()
}

class SignInViewController: UIViewController {
    
    // MARK: - Class properties.
    
    // MISC
    private lazy var userDp: UIImageView = UIImageView()
    private lazy var userDpPlus: UIImageView = UIImageView()
    private lazy var dpNote: UILabel = UILabel()
    private lazy var appName: UILabel = UILabel()
    private lazy var appVersion: UILabel = UILabel()
    private lazy var loginLink: UILabel = UILabel()
    
    // The text fields.
    private lazy var usernameTF: UITextField = UITextField()
    private lazy var passwordTF: UITextField = UITextField()
    private lazy var emailTF: UITextField = UITextField()
    
    // Prefix and suffix of the text fields.
    private lazy var eyeSlash: UIImageView = UIImageView(image: SystemIconConstants.eyeSlash)
    private lazy var eye: UIImageView = UIImageView(image: SystemIconConstants.eye)
    private lazy var lock: UIImageView = UIImageView(image: SystemIconConstants.lock)
    private lazy var person: UIImageView = UIImageView(image: SystemIconConstants.person)
    private lazy var email: UIImageView = UIImageView(image: SystemIconConstants.mail)
    
    // The buttons.
    private lazy var signInButton: UIButton = UIButton()
    
    // The main stack view.
    private lazy var stackView: UIStackView = UIStackView()
    
    // The selected text field.
    private var selectedTF: UITextField?
    
    // The social auth providers.
    private lazy var google: UIImageView = UIImageView()
    private lazy var apple: UIImageView = UIImageView()
    
    // MARK: - Class lifecycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the back button.
        self.navigationItem.hidesBackButton = true
        
        view.backgroundColor = ColorConstants.backgroundColor
        
        // Add the view as the delegate of UITextField.
        self.emailTF.delegate = self
        self.passwordTF.delegate = self
        self.usernameTF.delegate = self
        
        // To move up the screen if the keyboard hides the text field.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.self.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.self.keyboardWillHideNotification, object: nil)
        
        
        setupUI()
        
    }
    
    // MARK: - IB actions.
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        // Get the dimensions of the keyboard.
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if let selectedTF = selectedTF {
            let bottomOfTF = selectedTF.convert(selectedTF.bounds, to: self.view).maxY
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            self.view.layoutIfNeeded()
            
            if (bottomOfTF > topOfKeyboard) {
                UIView.animate(withDuration: 1) {
                    self.view.frame.origin.y = 0 - keyboardSize.height
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @objc private func toggleEye() {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
        passwordTF.rightView = passwordTF.isSecureTextEntry ? eye : eyeSlash
    }
    
    @objc private func signInButtonTap(_ sender: UIButton) {
        // TODO: sign in button tap.
    }
    
    @objc private func navToLoginController() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.viewControllers.remove(at: 0)
    }
    
    @objc private func dpTap() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    // MARK: - Class methods.
    
    private func setupUI() {
        
        // 1. Setup the user DP.
        userDpSetup()
        
        // 2. Setup the dp note.
        dpNoteSetup()
        
        // 3. Setup the stack view.
        setupStackView()
        
    }
    
    private func userDpSetup() {
        
        // Sub View to attach the User DP.
        
        let subView = UIView()
        self.view.addSubview(subView)
        subView.attachToTop(self.view)
        subView.halfOfScreen(self.view)
        
        // Get the default profile image.
        
        var image: UIImage? = UIImage()
        image = SystemIconConstants.defaultProfile
        
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
        
        // Adding interactivity to the Display picture.
        
        userDp.isUserInteractionEnabled = true
        userDp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dpTap)))
        
        // Adding a plus image on top of the default display picture.
        
        userDpPlus.image =  UIImage(named: AssetConstants.plus)?.circularImage(size: nil)
        userDpPlus.tintColor = ColorConstants.green
        userDp.addSubview(userDpPlus)
        
        userDpPlus.translatesAutoresizingMaskIntoConstraints = false
        userDpPlus.trailingAnchor.constraint(equalTo: userDp.trailingAnchor, constant: -10).isActive = true
        userDpPlus.bottomAnchor.constraint(equalTo: userDp.bottomAnchor, constant: -10).isActive = true
        userDpPlus.heightAnchor.constraint(equalToConstant: 30).isActive = true
        userDpPlus.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func dpNoteSetup() {
        dpNote.text = StringConstants.dpNote
        dpNote.font = dpNote.font.withSize(18)
        dpNote.textColor = .black
    }
    
    private func appNameSetup(_ sender: UILabel) -> UILabel {
        sender.text = StringConstants.appDisplayName
        sender.textColor = .white
        sender.font = sender.font.withSize(24.0)
        sender.textAlignment = NSTextAlignment.center
        
        return sender
    }
    
    private func setupTF() {
        usernameTF.leftViewMode = .always
        usernameTF.rightViewMode = .always
        usernameTF.leftView = person
        usernameTF.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        
        emailTF.leftViewMode = .always
        emailTF.rightViewMode = .always
        emailTF.leftView = email
        emailTF.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        
        
        passwordTF.leftViewMode = .always
        passwordTF.leftView = lock
        passwordTF.rightViewMode = .always
        passwordTF.rightView = eye
        
        setupPrefixSuffixTF([eye, eyeSlash], isPrefix: false)
        setupPrefixSuffixTF([lock, person, email], isPrefix: true)
        
    }
    
    private func commonTFSetup(_ sender: UITextField, hint: String) -> UITextField {
        sender.attributedPlaceholder = NSAttributedString(string: hint, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        sender.backgroundColor = ColorConstants.backgroundColor
        sender.tfBeautify()
        
        return sender
    }
    
    private func signInButtonSetup(_ sender: UIButton) -> UIButton {
        sender.backgroundColor = ColorConstants.backgroundColor
        sender.setTitle(StringConstants.signIn, for: .normal)
        sender.setTitleColor(ColorConstants.primaryColor, for: .normal)
        sender.buttonBeautify()
        
        // Setting up actions for the button.
        sender.addTarget(self, action: #selector(signInButtonTap(_ :)), for: .touchUpInside)
        
        return sender
    }
    
    private func socialAuthButton(_ sender: UIImageView, isGoogle: Bool) -> UIImageView {
        
        if isGoogle {
            // Set the dimensions.
            sender.heightAnchor.constraint(equalToConstant: 45).isActive = true
            sender.widthAnchor.constraint(equalToConstant: 45).isActive = true
            
            sender.image = UIImage(named: AssetConstants.google)
            return sender
        }
        
        // Set the dimensions.
        sender.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sender.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        sender.image = UIImage(named: AssetConstants.apple)
        
        return sender
    }
    
    
    private func loginLinkSetup() -> UILabel {
        loginLink.attributedText = NSAttributedString(string: StringConstants.dontHaveAnAccount, attributes: [NSAttributedString.Key.foregroundColor: ColorConstants.backgroundColor])
        loginLink.textAlignment = NSTextAlignment.center
        
        // Navigate user to the sign-in page when tapped on this label.
        loginLink.isUserInteractionEnabled = true
        loginLink.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navToLoginController)))
        
        return loginLink
    }
    
    
    private func setupPrefixSuffixTF(_ senders: [UIImageView], isPrefix: Bool) {
        for sender in senders {
            sender.heightAnchor.constraint(equalToConstant: 25).isActive = true
            sender.widthAnchor.constraint(equalToConstant: 30).isActive = true
            sender.tintColor = ColorConstants.primaryColor
            
            sender.isUserInteractionEnabled = true
            
            sender.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleEye)))
            
            if (!isPrefix) {
                sender.layer.transform = CATransform3DMakeTranslation(-14, 0, 8)
            }
            
        }
    }
    
    private func setupStackView() {
        let subview = UIView()
        
        view.addSubview(subview)
        subview.backgroundColor = ColorConstants.primaryColor
        subview.halfOfScreen(self.view)
        subview.attachToBottom(self.view, bottom: 24, trailing: 8, leading: 8)
        subview.beautify(radius: 30.0)
        
        subview.addSubview(stackView)
        
        // Adding the App version.
        self.appVersion.text = StringConstants.appVersion
        self.appVersion.font = self.appVersion.font.withSize(12)
        self.appVersion.textColor = .white
        self.appVersion.textAlignment = NSTextAlignment.center
        subview.addSubview(appVersion)
        self.appVersion.attachToBottom(subview)
        
        // Constraint the stack view.
        stackView.attachToTop(subview)
        stackView.axis = .vertical
        stackView.spacing = 8.0
        
        // Adding the social auth.
        let googleView = socialAuthButton(google, isGoogle: true)
        let appleView = socialAuthButton(apple, isGoogle: false)
        
        subview.addSubview(appleView)
        subview.addSubview(googleView)
        
        googleView.translatesAutoresizingMaskIntoConstraints = false
        googleView.centerXAnchor.constraint(equalTo: subview.centerXAnchor, constant: 35).isActive = true
        googleView.bottomAnchor.constraint(equalTo: self.appVersion.topAnchor, constant: -10).isActive = true
        appleView.translatesAutoresizingMaskIntoConstraints = false
        appleView.bottomAnchor.constraint(equalTo: self.appVersion.topAnchor, constant: -10).isActive = true
        
        let horizontalSpace = NSLayoutConstraint(item: googleView, attribute: .leading, relatedBy: .equal, toItem: appleView, attribute: .trailing, multiplier: 1, constant: 20)
        
        NSLayoutConstraint.activate([horizontalSpace])
        
        setupTF()
        
        addToStack(widgets: [appNameSetup(appName), commonTFSetup(emailTF, hint: StringConstants.email), commonTFSetup(usernameTF, hint: StringConstants.username), commonTFSetup(passwordTF, hint: StringConstants.password), signInButtonSetup(signInButton), loginLinkSetup()])
    }
    
    private func addToStack(widgets: [UIView]) {
        for widget in widgets {
            stackView.addArrangedSubview(widget)
        }
    }
    
    private func manageResponders() {
        switch selectedTF {
        case self.emailTF:
            let _ = self.usernameTF.becomeFirstResponder()
            break
        case self.usernameTF:
            let _ = self.passwordTF.becomeFirstResponder()
            break
        case self.passwordTF:
            self.passwordTF.resignFirstResponder()
            break
        default:
            break
        }
    }
}

// MARK: - UITextFieldDelegate.

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Set the current active text field.
        self.selectedTF = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Set the active text field to nil.
        self.selectedTF = nil
    }
    
    // Close the keyboard when the user presses return.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.manageResponders()
        
        return false
    }
}

// MARK: - SignInViewDelegate.

extension SignInViewController: SignInViewDelegate {
    func displayError() {
        // TODO: Display error fetching Display Picture. 
    }
    
    
    func updateDP(image: UIImage) {
        self.userDp.image = image
    }
    
}

// MARK: - UIImagePickerControllerDelegate.

extension SignInViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Picked an image.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
    
        
        userDp.image = image.circularImage(size: nil)
        
        dismiss(animated: true)
    }
}
