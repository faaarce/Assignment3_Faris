//
//  AuthenticationManager.swift
//  Exercise
//
//  Created by yoga arie on 15/07/24.
//

import Foundation
import RxSwift

class AuthenticationManager: AuthenticationService {
  
  let apiManager: APIService
  
  init(apiManager: APIService) {
    self.apiManager = apiManager
  }
  
  func signIn(username: String, password: String) -> RxSwift.Single<SignInResponse> {
    apiManager.request(AuthenticationAPI.signin(username: username, password: password))
  }
  
  
}
