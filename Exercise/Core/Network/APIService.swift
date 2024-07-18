//
//  APIService.swift
//  Exercise
//
//  Created by yoga arie on 15/07/24.
//

import RxSwift

// Question = T.Type, any
protocol APIService {
  func request<T: Decodable>(_ api: any API, of: T.Type) -> Single<T>
  func request<T: Decodable>(_ api: any API) -> Single<T>
}
