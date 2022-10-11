import Foundation
import RSSwiftNetworking

internal enum AuthEndpoint: RailsAPIEndpoint {
    
    private static let authURL = "/auth"
    
    case signIn(email: String, password: String)
    case signUp(
        email: String,
        name: String,
        password: String
    )
    case logout
        
    var path: String {
        switch self {
        case .signIn:
            return AuthEndpoint.authURL + "/sign_in"
        case .signUp:
            return AuthEndpoint.authURL
        case .logout:
            return AuthEndpoint.authURL + "/sign_out"
        }
    }
    
    var method: Network.HTTPMethod {
        switch self {
        case .signIn, .signUp:
            return .post
        case .logout:
            return .delete
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .signIn(let email, let password):
            return [
                "user": [
                    "email": email,
                    "password": password
                ]
            ]
        case .signUp(let email, let name, let password):
            var parameters = [
                "email": email,
                "name": name,
                "password": password
            ]
            return ["user": parameters]
        default:
            return [:]
        }
    }
}
