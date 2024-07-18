//
//  AuthenticationAPI.swift
//  Exercise
//
//  Created by yoga arie on 15/07/24.
//

import Foundation
import Alamofire

// Question = enum, computed property
enum AuthenticationAPI: API {
  
  case signin(username: String, password: String)
  case signup(username: String, email: String, password: String)
  
  private var baseURL: String {
    "http://localhost:3001"
  }
  
  var url: any URLConvertible {
    switch self {
    case .signin:
      return "\(baseURL)/auth/signin"
      
    case .signup:
      return "\(baseURL)/auth/signup"
    }
  }
  
  var method: Alamofire.HTTPMethod {
    return .post
  }
  
  
  var params: Alamofire.Parameters? {
    switch self {
      
    case .signin(username: let username, password: let password):
      return [
        "username" : username,
        "password" : password
      ]
      
    case .signup(username: let username, email: let email, password: let password):
      return [
        "username" : username,
        "email" : email,
        "password" : password
      ]
    }
  }
  
  
}
