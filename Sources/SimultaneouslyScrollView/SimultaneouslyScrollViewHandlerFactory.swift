import Foundation

/// Factory class to create `SimultaneouslyScrollViewHandler` instance
public class SimultaneouslyScrollViewHandlerFactory {
    /// Creates a new `SimultaneouslyScrollViewHandler` instance
    /// - Returns: A new `SimultaneouslyScrollViewHandler` instance
    public static func create() -> SimultaneouslyScrollViewHandler {
        DefaultSimultaneouslyScrollViewHandler()
    }
}
