import Combine
import Resolver
import Foundation

typealias Output = URLSession.DataTaskPublisher.Output

protocol NetworkAgentProtocol {
    func run<T: Decodable>(_ router: WeatherRoutable) -> AnyPublisher<ApiResponse<T>, WeatherError.Api>
}

final class NetworkAgent: NetworkAgentProtocol {}

// MARK: - Combine implemention base

extension NetworkAgent {
    func run<T: Decodable>(
        _ router: WeatherRoutable
    ) -> AnyPublisher<ApiResponse<T>, WeatherError.Api> {
        do {
            let request = try router.buildRequest()
            return URLSession.shared
                .dataTaskPublisher(for: request)
                .tryMap { try self.handleDataTaskOutput($0) }
                .tryMap { try self.handleDataMapper(statusCode: $0, with: $1, to: router) }
                .mapError { self.handleDataTaskError($0)}
                .eraseToAnyPublisher()
        } catch {
            return Fail<ApiResponse<T>, WeatherError.Api>(error: error as? WeatherError.Api ?? .undefined).eraseToAnyPublisher()
        }
    }
}

// MARK: - Combine handle response

extension NetworkAgent {
    func handleDataTaskOutput(
        _ output: Output
    ) throws -> (Int, Data) {
        debugPrint("[HTTP REQUEST]", output.response.url as Any)
        debugPrint("[HTTP STATUS CODE]", (output.response as? HTTPURLResponse)?.statusCode ?? .zero)
        
        guard let httpResponse = output.response as? HTTPURLResponse else {
            throw WeatherError.Api.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return (httpResponse.statusCode, output.data)
        case 401:
            throw WeatherError.Api.undefined
        default:
            throw WeatherError.Api.invalidResponse
        }
    }
    
    func handleDataTaskError(
        _ error: Error
    ) -> WeatherError.Api {
        if let error = error as? URLError, error.code != .timedOut {
            return WeatherError.Api.timeOut
        }
        return error as? WeatherError.Api ?? .undefined
    }
    
    func handleDataMapper<T: Decodable>(
        statusCode: Int,
        with data: Data,
        to router: WeatherRoutable
    ) throws -> ApiResponse<T> {
        guard let resultDecode: T = decode(data) else {
            try printData(for: data)
            throw WeatherError.Api.invalidDecodableModel
        }
        try printData(for: data)
        
        return ApiResponse(
            response: resultDecode,
            code: statusCode
        )
    }
    
    func printData(for data: Data) throws {
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return
        }
        debugPrint("[HTTP RESPONSE] ", json)
    }
}

extension NetworkAgent {
    func decode<T: Decodable>(_ data: Data) -> T? {
        var response: T?
        do {
            response = try JSONDecoder().decode(T.self, from: data)
        } catch {
            debugPrint("[HTTP MAPPER] [ERROR]", String(describing: T.self), error)
        }
        debugPrint("[HTTP MAPPER]", String(describing: T.self))
        return response
    }
}
