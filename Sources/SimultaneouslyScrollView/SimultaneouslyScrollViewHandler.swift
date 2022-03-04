import Combine
import UIKit

/// Handler to enable simultaneously scrolling of `ScrollView`s
public protocol SimultaneouslyScrollViewHandler {
    /// Publisher to notify if the `ScrollView`s are scrolled to the bottom
    var scrolledToBottomPublisher: AnyPublisher<Bool, Never> { get }

    /// Adds the `ScrollView` to a list and keep the content offset in sync.
    /// When any registered `ScrollView` will be scrolled all other registered `ScrollView` will adjust
    /// its content offset automatically.
    /// - Parameters:
    ///     - scrollView: The `ScrollView` that should be registered for simultaneously scrolling
    func register(scrollView: UIScrollView)

    /// Helper method to scroll all registered `ScrollView`s to the bottom.
    func scrollAllToBottom(animated: Bool)
}
