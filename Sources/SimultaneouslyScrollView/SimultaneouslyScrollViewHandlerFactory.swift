import Foundation

/// Factory class to create `SimultaneouslyScrollViewHandler` instance
@available(iOS 13, *)
@available(tvOS 13, *)
@available(visionOS 1, *)
@available(macOS, unavailable)
public class SimultaneouslyScrollViewHandlerFactory {
#if os(iOS) || os(tvOS) || os(visionOS)
    /// Creates a new `SimultaneouslyScrollViewHandler` instance
    /// - Returns: A new `SimultaneouslyScrollViewHandler` instance
    public static func create() -> SimultaneouslyScrollViewHandler {
        DefaultSimultaneouslyScrollViewHandler()
    }
#else
    public static func create() -> SimultaneouslyScrollViewHandler {
        // Stub for other platforms
        fatalError()
    }
#endif
}
