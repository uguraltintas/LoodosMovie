//
//  APIClient.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 19.11.2024.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
    func send<T: Endpoint>(_ endpoint: T) async throws -> T.Response
}

final class APIClient: APIClientProtocol {
    private let session: Session

    init(session: Session = .default) {
        self.session = session
    }

    func send<T: Endpoint>(_ endpoint: T) async throws -> T.Response {
            guard let url = endpoint.url else {
                throw NetworkError.invalidURL
            }

            return try await withCheckedThrowingContinuation { continuation in
                session.request(url, method: endpoint.method)
                    .validate()
                    .responseDecodable(of: T.Response.self) { response in
                        switch response.result {
                        case .success(let value):
                            continuation.resume(returning: value)

                        case .failure(let afError):
                            let networkError = self.mapAlamofireError(afError,
                                                                      data: response.data,
                                                                      response: response.response)
                            continuation.resume(throwing: networkError)
                        }
                    }
            }
        }

        private func mapAlamofireError(_ error: AFError,
                                       data: Data?,
                                       response: HTTPURLResponse?) -> NetworkError {
            if let data {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    return .serverError(errorResponse.error ?? "unknown_error".localized)
                } catch {
                    return .decodingError
                }
            }

            switch error {
            case .invalidURL:
                return .invalidURL
            case .requestAdaptationFailed:
                if let statusCode = response?.statusCode {
                    switch statusCode {
                    case 400...499:
                        return .badRequest
                    case 500...599:
                        return .serverError(error.localizedDescription)
                    default:
                        return .unknownError
                    }
                }
                return .unknownError
            default:
                return .unknownError
            }
        }
}
