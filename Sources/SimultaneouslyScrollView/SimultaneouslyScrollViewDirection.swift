#if os(iOS) || os(tvOS) || os(visionOS)
import Foundation

public struct SimultaneouslyScrollViewDirection: OptionSet {
    public var rawValue: Int

    public static let horizontal = SimultaneouslyScrollViewDirection(rawValue: 1 << 0)
    public static let vertical = SimultaneouslyScrollViewDirection(rawValue: 2 << 0)

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
#endif
