//
//  Networking.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/02/11.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation
import SystemConfiguration

enum HttpMethod: String {
    case get
    case post
    case put
    case delete
    
    var value: String {
        return rawValue
    }
}

enum StatusCode {
    case success
    case fail
    case server
}

private func networking(method: HttpMethod, url: URL, data: Data, completion: @escaping(Data?, URLResponse?, Error?) -> Void) -> StatusCode {
    var statusCode: Int = -1
    let semaphore = DispatchSemaphore(value: 0)
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.value
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    urlRequest.setValue(UserDefaults.standard.string(forKey: "accessToken"), forHTTPHeaderField: "Authorization")
    urlRequest.httpBody = data
    
    let session = URLSession(configuration: .default)
    
    let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
        if let httpResponse = response as? HTTPURLResponse {
            statusCode = httpResponse.statusCode
        } else {
            print("no response")
            completion(data, response, error)
        }
        
        completion(data, response, error)
        semaphore.signal()
    }
    
    dataTask.resume()
    semaphore.wait()
    
    switch statusCode {
    case 200...299:
        return .success
    case 400...499:
        return .fail
    default:
        return .server
    }
}

private let baseURL = WishBallAPI().serverAddress

/// 유저 등록
func registUser(regist: Regist) -> StatusCode {
    guard let url = URL(string: baseURL + WishBallAPI().regist) else {
        return .fail
    }
    
    guard let data = try? JSONEncoder().encode(regist) else {
        return .fail
    }
    
    let statusCode = networking(method: .post, url: url, data: data) { (data, response, error) in
        print("data \(response)")
    }
    
    return statusCode
}

/// 로그인 요청
func requestLogin(regist: Regist, completion: @escaping(Login) -> Void) -> StatusCode {
    guard let url = URL(string: baseURL + WishBallAPI().login) else {
        return .fail
    }
    
    guard let data = try? JSONEncoder().encode(regist) else {
        return .fail
    }
    
    let statusCode = networking(method: .post, url: url, data: data) { (data, response, error) in
        if let data = data, let jsonData = try? JSONDecoder().decode(Login.self, from: data) {
            print("Login API == \(jsonData)")
            completion(jsonData)
        }
    }
    
    return statusCode
}

/// 콜렉션 리스트 요청
func requestWholeCollection(completion: @escaping(Collection) -> Void) -> StatusCode {
    guard let url = URL(string: baseURL + WishBallAPI().collections) else {
        return .fail
    }
    
    let statusCode = networking(method: .get, url: url, data: Data()) { (data, response, error) in
        if let data = data, let jsonData = try? JSONDecoder().decode(Collection.self, from: data) {
            print("Collection API == \(jsonData)")
            completion(jsonData)
        }
    }
    
    return statusCode
}

/// 네이버 쇼핑 검색 리스트 요청
func requestSearchList(itemTitle: String, completion: @escaping(Search) -> Void) -> StatusCode {
    guard var urlComponents = URLComponents(string: baseURL + WishBallAPI().search) else {
        return .fail
    }
    urlComponents.queryItems = [URLQueryItem(name: "itemName", value: itemTitle)]
    guard let url = urlComponents.url else {
        return .fail
    }
    
    let statusCode = networking(method: .get, url: url, data: Data()) { (data, response, error) in
        if let data = data, let jsonData = try? JSONDecoder().decode(Search.self, from: data) {
            completion(jsonData)
        }
    }
    
    return statusCode
}
