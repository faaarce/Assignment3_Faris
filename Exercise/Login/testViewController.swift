//
//  SignInViewController.swift
//  Exercise
//
//  Created by yoga arie on 16/07/24.
//

import UIKit

class testViewController: UIViewController {

  
  weak var emailTextField: UITextField!
  weak var emailLabel: UILabel!
  weak var passwordLabel: UILabel!
  weak var passwordTextField: UITextField!
  weak var signInButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
  
  
    
  func setupViews() {
    view.backgroundColor = .white
    let emailLabel = UILabel(frame: .zero)
    view.addSubview(emailLabel)
    self.emailLabel = emailLabel
    emailLabel.text = "Email"
    emailLabel.textColor = .black
    emailLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    emailLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      emailLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
    ])
    
    
    let emailTextField = UITextField(frame: .zero)
    view.addSubview(emailTextField)
    self.emailTextField = emailTextField
    emailTextField.placeholder = "E-Mail"
    emailTextField.keyboardType = .emailAddress
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      
    ])
    
    
    let passwordLabel = UILabel(frame: .zero)
    view.addSubview(passwordLabel)
    self.passwordLabel = passwordLabel
    passwordLabel.text = "Password"
    passwordLabel.textColor = .black
    passwordLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    passwordLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      
    ])
    
    let passwordTextField = UITextField(frame: .zero)
    view.addSubview(passwordTextField)
    self.passwordTextField = passwordTextField
    passwordTextField.placeholder = "Password"
    passwordTextField.keyboardType = .default
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      
    ])
    
  }
    

}
