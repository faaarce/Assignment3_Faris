//
//  SignUpViewController.swift
//  Exercise
//
//  Created by yoga arie on 16/07/24.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      title = "Sign Up"
        // Do any additional setup after loading the view.
    }


}


extension UIViewController {
  func moveToSignUp() {
    let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
    navigationController?.pushViewController(vc, animated: true)
  }
}
