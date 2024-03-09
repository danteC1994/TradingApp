//
//  EndpointGetRequest.swift
//  TradingApp
//
//  Created by dante canizo on 08/03/2024.
//

import Foundation

struct EndpointGetRequest<T> where T: Decodable {
    let decoder: Decoder
    let endpoint: Endpoint
    let session: URLSession

    init(coder: Decoder, endpoint: Endpoint, session: URLSession) {
        self.decoder = JsonCoder()
        self.endpoint = endpoint
        self.session =  .init(configuration: .default)
    }

    func asyncGetrequest() async -> Result<T, APIError> {
        guard let url = endpoint.getUrlRequest()
        else {
            assertionFailure("Error while creating url for \(endpoint.endpointPath)")
            return .failure(.url)
        }
        
        let data: Data
        do {
            (data, _) = try await session.data(from: url)
        } catch {
            assertionFailure("Error while requesting \(endpoint.endpointPath)")
            return .failure(APIError.network)
        }

        guard let response = decoder.decode(data: data, dataType: T.self) else {
            assertionFailure("Error while decoding \(endpoint.endpointPath)")
            return .failure(.decoding)
        }
        
        return .success(response)
    }
}
