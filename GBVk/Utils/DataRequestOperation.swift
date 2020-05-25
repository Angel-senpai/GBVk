//
//  DataRequestOperation.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 24.05.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import Alamofire

class DataRequestOperation: AsyncOperation{
    private var request: DataRequest
    var data: Data?
    var error: NetworkError?
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    override func main() {
        request.responseData(queue: DispatchQueue.global()){
            [weak self] response in
            guard let self = self else {return}
            switch response.result{
                
            case .success(let data):
                self.data = data
                
            case .failure(let error):
                self.error = .failedRequest(message: error.localizedDescription)
            }
            self.state = .finished
        }
    }
    
    init(request: DataRequest) {
        self.request = request
    }
    
}
