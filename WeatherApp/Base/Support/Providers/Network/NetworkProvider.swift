protocol NetworkProviderProtocol {
    var agent: NetworkAgentProtocol { get }
}

public final class NetworkProvider: NetworkProviderProtocol {
    var agent: NetworkAgentProtocol
    init() { agent = NetworkAgent() }
}
