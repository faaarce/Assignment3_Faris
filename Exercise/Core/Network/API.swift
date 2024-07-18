//
//  API.swift
//  Exercise
//
//  Created by yoga arie on 15/07/24.
//

import Alamofire

protocol API {
  var url: URLConvertible { get }
  var method: HTTPMethod { get }
  var params: Parameters? { get }
}
