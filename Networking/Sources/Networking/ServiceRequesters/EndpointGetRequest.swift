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
    let session: Session

    init(coder: Decoder, endpoint: Endpoint, session: Session) {
        self.decoder = coder
        self.endpoint = endpoint
        self.session = session
    }

    init(endpoint: Endpoint) {
        decoder = JsonCoder()
        self.endpoint = endpoint
        session = URLSession(configuration: .default)
    }

    /// Generic requester for endpoints with HTTP GET Restful method.
    func asyncGetrequest() async -> Result<T, APIError> {
        guard let url = endpoint.getUrl() else { return .failure(.url) }
        
        let data: Data
        do {
            (data, _) = try await session.data(from: url)
        } catch {
            return .failure(APIError.network)
        }

        guard let response = decoder.decode(data: data, dataType: T.self) else {
            return .failure(.decoding)
        }
        
        return .success(response)
    }
}
