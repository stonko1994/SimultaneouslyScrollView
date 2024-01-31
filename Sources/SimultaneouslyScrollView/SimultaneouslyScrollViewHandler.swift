import Combine
#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit
#endif

/// Handler to enable simultaneously scrolling of `ScrollView`s
@available(iOS 13, *)
@available(tvOS 13, *)
@available(visionOS 1, *)
@available(macOS, unavailable)
public protocol SimultaneouslyScrollViewHandler {
#if os(iOS) || os(tvOS) || os(visionOS)
    /// Publisher to notify if the `ScrollView`s are scrolled to the bottom
    var scrolledToBottomPublisher: AnyPublisher<Bool, Never> { get }

    /// Adds the `ScrollView` to a list and keep the content offset in sync.
    /// When any registered `ScrollView` will be scrolled all other registered `ScrollView` will adjust
    /// its content offset automatically.
    /// - Parameters:
    ///     - scrollView: The `ScrollView` that should be registered for simultaneously scrolling
    func register(scrollView: UIScrollView)

    /// Adds the `ScrollView` to a list and keep the content offset in sync.
    /// When any registered `ScrollView` will be scrolled all other registered `ScrollView` will adjust
    /// its content offset automatically.
    /// - Parameters:
    ///     - scrollView: The `ScrollView` that should be registered for simultaneously scrolling
    ///     - scrollDirections: The `SimultaneouslyScrollViewDirection` directions interested
    func register(scrollView: UIScrollView, scrollDirections: SimultaneouslyScrollViewDirection?)

    /// Helper method to scroll all registered `ScrollView`s to the bottom.
    func scrollAllToBottom(animated: Bool)
#endif
}
