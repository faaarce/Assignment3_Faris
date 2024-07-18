//
//  SignUpViewController.swift
//  Exercise
//
//  Created by yoga arie on 16/07/24.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
  
  @IBOutlet weak var passwordPlaceholder: UIView!
  @IBOutlet weak var emailPlaceholder: UIView!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Sign In"
    
    resetInputFields()
  }
  
  
  @IBAction func forgotButtonTapped(_ sender: Any) {
    showTabbarViewController()
  }
  
  func isValid() -> Bool {
    var isValid = true
    if let email = emailTextField.text, !email.isValidEmail  {
      emailPlaceholder.backgroundColor = UIColor.red
      isValid = false
    } else {
      emailPlaceholder.backgroundColor = UIColor(hex: "F3F2F2", alpha: 1.0)
    }
    
    if let password = passwordTextField.text, password.count < 3 {
      passwordPlaceholder.backgroundColor = UIColor.red
      isValid = false
    } else {
      passwordPlaceholder.backgroundColor = UIColor(hex: "F3F2F2", alpha: 1.0)
    }
    return isValid
  }
  
  @IBAction func signInButtonTapped(_ sender: Any) {
    resetInputFields()
    
    if isValid(){
      
      presentLoadingView(message: "Signing in...")
      
      performSignIn()
    } else {
      var errorMessage = ""
      if emailTextField.text?.isValidEmail == false {
        errorMessage += "Invalid email format.\n"
      }
      
      if passwordTextField.text?.count ?? 0 < 3 {
        errorMessage += "Password must be at least 3 characters long"
      }
      
      presentErrorAlert(message: errorMessage)
      Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { [weak self] timer in
        self?.resetInputFields()
      }
    }
    
    
  }
  
  @IBAction func signUpButtonTapped(_ sender: Any) {
    moveToSignUp()
  }
  
  private func performSignIn() {
    
    guard let email = emailTextField.text, let password = passwordTextField.text else {
      presentErrorAlert(message: "Email and password cannot be empty")
      return
    }
    
    Auth.auth().signIn(withEmail: email, password: password)  { [weak self] authResult, error in
      DispatchQueue.main.async {
        self?.dismissLoadingView()
        if let error = error {
          Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] timer in
            self?.presentErrorAlert(message: error.localizedDescription)
          }
        } else if authResult?.user != nil {
          self?.showTabbarViewController()
        } else {
          Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] timer in
            self?.presentErrorAlert(message: "Authentication failed for an unknown reason")
          }
          
        }
      }
    }
  }
  
  private func presentErrorAlert(message: String) {
    let error = UIAlertController(title: "Login Error", message: message, preferredStyle: .alert)
    error.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
      self.resetInputFields()
    }))
    present(error, animated: true)
  }
  
  private func resetInputFields() {
    emailPlaceholder.backgroundColor = UIColor(hex: "F3F2F2", alpha: 1.0)
    passwordPlaceholder.backgroundColor = UIColor(hex: "F3F2F2", alpha: 1.0)
  }
  
  
}

extension UIViewController {
  func moveToSignInPage() {
    let signViewController = SignInViewController(nibName: "SignInViewController", bundle: nil)
    navigationController?.pushViewController(signViewController, animated: true)
  }
}
