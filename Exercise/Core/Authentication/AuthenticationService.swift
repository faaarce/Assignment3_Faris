//
//  AuthenticationService.swift
//  Exercise
//
//  Created by yoga arie on 15/07/24.
//

import Foundation
import RxSwift

protocol AuthenticationService {
  func signIn(username: String, password: String) -> Single<SignInResponse>
}
