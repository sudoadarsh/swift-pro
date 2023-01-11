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
    2. Adding height and width to [UIImageView]
    3. Adding subviews in a stack programatically
    4. Moving the View up when keyboard is visible.
    5. Always remeber to add delegates.
    6. Basic Animations in swift.
 */

class LoginViewController: UIViewController {
    
    // MARK: Class properties.
    
    private lazy var appLogo: UIImageView = UIImageView()
    private lazy var appName: UILabel = UILabel()
    private lazy var loginButton: UIButton = UIButton()
    private lazy var continueWithGoogle: UIButton = UIButton()
    private lazy var continueWithApple: UIButton = UIButton()
    private lazy var usernameTF: UITextField = UITextField()
    private lazy var passwordTF: ASPasswordTF = ASPasswordTF()
    private lazy var signInLink: UILabel = UILabel()
    private lazy var stackView = UIStackView()
    private var activeTF: UITextField?
    private lazy var usernameVE: UILabel = UILabel()
    private lazy var passwordVE: UILabel = UILabel()
    private lazy var appVersion: UILabel = UILabel()
    private lazy var eyeSlash: UIImageView = UIImageView(image: SystemIconConstants.eyeSlash)
    private lazy var eye: UIImageView = UIImageView(image: SystemIconConstants.eye)
    private lazy var lock: UIImageView = UIImageView(image: SystemIconConstants.lock)
    private lazy var person: UIImageView = UIImageView(image: SystemIconConstants.person)
    
    // MARK: - App life cycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The background color.
        view.backgroundColor = ColorConstants.backgroundColor
        
        // The keyboard show/ hide listeners.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardVisible), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Adding the class to the delegate of UITextFields.
        self.usernameTF.delegate = self
        self.passwordTF.delegate = self
        
        setupUI()
    }
    
    // MARK: IB actions.
    
    @objc private func keyboardVisible(notification: NSNotification) {
        
        // Get the Size of the keyboard.
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        // Get the bottom of active TF.
        if let activeTF = activeTF {
            let bottomOfTF = activeTF.convert(activeTF.bounds, to: self.view).maxY
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            self.view.layoutIfNeeded()
            if bottomOfTF > topOfKeyboard {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.view.frame.origin.y = 0 - keyboardSize.height
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc private func keyboardHidden(notification: NSNotification) {
        
        // Set the axis of the screen back to normal.
        self.view.frame.origin.y = 0
    }
    
    @objc private func loginButtonTap(_ sender: UIButton) {
        
        // Password validation.
        let password: String = self.passwordTF.text ?? ""
        let passwordRange: NSRange = NSRange(password.startIndex..<password.endIndex, in: password)
        let passwordValid = RegX.passwordRegex.matches(in: password, options: [], range: passwordRange)

        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.usernameVE.isHidden = !(self.usernameTF.text?.isEmpty ?? true)
            self.passwordVE.isHidden = !(passwordValid.isEmpty)
        })
        
    }
    
    @objc private func navToSignInController() {
        let vc = SignInViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        // Remove the [LoginViewController] from the stack.
        self.navigationController?.viewControllers.remove(at: 0)
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
    
    private func TFSetup() {
        
        // Password field setup.
        passwordTF.leftViewMode = .always
        passwordTF.rightViewMode = .always
        passwordTF.isSecureTextEntry = true
        passwordTF.clearsOnBeginEditing = false
        passwordTF.rightView = eye
        passwordTF.leftView = lock
        
        // Username field setup.
        usernameTF.leftViewMode = .always
        usernameTF.rightViewMode = .always
        usernameTF.leftView = person
        usernameTF.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))

    }
    
    private func commonTFSetup(_ sender: UITextField, hint: String) -> UITextField {
        sender.attributedPlaceholder = NSAttributedString(string: hint, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
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
        
        // Setting up actions for the button.
        sender.addTarget(self, action: #selector(loginButtonTap(_ :)), for: .touchUpInside)
        
        return sender
    }
    
    private func googleLoginSetup() -> UIButton {
        continueWithGoogle.backgroundColor = UIColor.red
        continueWithGoogle.setTitle(StringConstants.continueWithGoogle, for: .normal)
        continueWithGoogle.buttonBeautify()
        
        return continueWithGoogle
    }
    
    private func appleLoginSetup() -> UIButton {
        continueWithApple.backgroundColor = UIColor.black
        continueWithApple.setTitle(StringConstants.continueWithApple, for: .normal)
        continueWithApple.buttonBeautify()
        
        return continueWithApple
    }
    
    private func signInLinkSetup() -> UILabel {
        signInLink.attributedText = NSAttributedString(string: StringConstants.dontHaveAnAccount, attributes: [NSAttributedString.Key.foregroundColor: ColorConstants.backgroundColor])
        signInLink.textAlignment = NSTextAlignment.center
        
        // Navigate user to the sign-in page when tapped on this label.
        signInLink.isUserInteractionEnabled = true
        signInLink.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navToSignInController)))
        
        return signInLink
    }
    
    private func validationErrSetup(_ sender: [UILabel]) {
        
        for i in 0..<sender.count {
            sender[i].textAlignment = NSTextAlignment.left
            sender[i].font = sender[i].font.withSize(12)
            sender[i].textColor = ColorConstants.errorColor
            sender[i].numberOfLines = 0
            sender[i].isHidden = true
            sender[i].text = i == 0 ? StringConstants.usernameVE : StringConstants.passwordVE
        }
    }
    
    private func stackContentSetup() {
        
        TFSetup()
        
        setupPrefixSuffixTF([eye, eyeSlash], isPrefix: false)
        setupPrefixSuffixTF([lock, person], isPrefix: true)

        let subView = UIView()
        
        subView.backgroundColor = ColorConstants.primaryColor
        self.view.addSubview(subView)
        
        subView.halfOfScreen(self.view)
        subView.attachToBottom(self.view, bottom: 24, trailing: 8, leading: 8)
        subView.beautify(radius: 30.0)
        
        // Adding the App version.
        self.appVersion.text = StringConstants.appVersion
        self.appVersion.font = self.appVersion.font.withSize(12)
        self.appVersion.textColor = .white
        self.appVersion.textAlignment = NSTextAlignment.center
        subView.addSubview(appVersion)
        self.appVersion.attachToBottom(subView)
        
        // Adding the stackview to the SubView.
        subView.addSubview(stackView)
        stackView.attachToTop(subView)
                
        // Start adding elements into the stack view.
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 8.0
        
        self.validationErrSetup([usernameVE, passwordVE])
        
        // List of widget to be added to the stack.
        let widgets: [UIView] = [appNameSetup(appName), commonTFSetup(usernameTF, hint: StringConstants.username), usernameVE, commonTFSetup(passwordTF, hint: StringConstants.password), passwordVE, loginButtonSetup(loginButton), googleLoginSetup(), appleLoginSetup(), signInLinkSetup()]
        
                
        self.addToStack(widgets: widgets)
        
        
    }
    
    private func addToStack(widgets: [UIView]) {
        for widget in widgets {
            stackView.addArrangedSubview(widget)
        }
    }
    
    private func manageTFResponder() {
        switch activeTF {
        case self.usernameTF:
            let _ = self.passwordTF.becomeFirstResponder()
        default:
            self.passwordTF.resignFirstResponder()
        }
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
    
    @objc private func toggleEye() {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
        passwordTF.rightView = passwordTF.isSecureTextEntry ? eye : eyeSlash
    }
    
}

// MARK: - UI Text Field delegate.

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTF = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTF = nil
    }
    
    // To close the keyboard when user is presses [Return].
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.manageTFResponder()
        return false
    }
}
