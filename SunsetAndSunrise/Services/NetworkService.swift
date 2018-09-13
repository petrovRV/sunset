//
//  NetworkService.swift
//  SunsetAndSunrise
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

struct NetworkService {
    
    static let instance = NetworkService()
    
    private init() {}
    
    //MARK: - Properties private
    private let decoder = JSONDecoder()
    
    //MARK: - Methods public
    func getData<ResponseModel: Decodable>(with strUrl: String, type: ResponseModel.Type, responseModel: @escaping (ResponseModel)->()) {
        
        guard let url = URL(string: strUrl) else {
            print("Error url")
            return
        }
        
        getData(with: url, type: type, responseModel: responseModel)
        
    }

    func getData<ResponseModel: Decodable>(with url: URL?, type: ResponseModel.Type, responseModel: @escaping (ResponseModel)->()) {
        
        guard let urlRequest = url else {
            print("Error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            guard let data = data else { return }
            
            guard let object = self.convertDataToObject(with: data, type: type) else {
                print("Error: convert data to object")
                return
            }
            
            responseModel(object)
        }
        
        task.resume()
        
    }
    
    //MARK: - Methods private
    private func convertDataToObject<ResponseModel: Decodable>(with data: Data?, type: ResponseModel.Type) -> ResponseModel? {
        
        guard let data = data else {
            print("Error: response from server equal nil")
            return nil
        }
        print(String(data: data, encoding: .utf8)!)
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? self.decoder.decode(ResponseModel.self, from: data)
        
    }
    
}
