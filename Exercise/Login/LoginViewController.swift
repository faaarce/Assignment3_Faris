//
//  LoginViewController.swift
//  Exercise
//
//  Created by yoga arie on 15/07/24.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
  
  private var authenticationManager: AuthenticationManager!
  private let disposeBag = DisposeBag()
  
  init(apiManager: APIService) {
    self.authenticationManager = AuthenticationManager(apiManager: apiManager)
    super.init(nibName: "LoginViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBinding()
  }
  
  func setupBinding() {
    authenticationManager.signIn(username: "jokowi", password: "jokowi")
      .subscribe { event in
        switch event {
        case .success(let response):
          if response.success {
            print("sukses")
          } else {
            print("gagal")
          }
          
        case .failure(let error):
          print("error")
        }
      }
      .disposed(by: disposeBag)
  }
  
}
