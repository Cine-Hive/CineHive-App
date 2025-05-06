//
//  ResponseWithStatusCode.swift
//  CineHive
//
//  Created by 존진 on 5/6/25.
//

import Foundation

protocol ResponseWithStatusCode {
    var statusCode: Int { get set }
}

extension ResponseWithStatusCode {
    mutating func injectStatusCode(_ code: Int) {
        self.statusCode = code
    }
}

func decodeResponse<T: Decodable>(data: Data, response: HTTPURLResponse) throws -> T {
    let decoded = try JSONDecoder().decode(T.self, from: data)

    if var responseWithCode = decoded as? any ResponseWithStatusCode {
        responseWithCode.injectStatusCode(response.statusCode)

        if let typedResponse = responseWithCode as? T {
            return typedResponse
        }
    }

    return decoded
}
