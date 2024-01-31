#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

internal extension UIScrollView {
    var isAtBottom: Bool {
        contentOffset.y >= (contentSize.height - frame.size.height)
    }

    var hasContentToFillScrollView: Bool {
        contentSize.height > bounds.size.height
    }
}
#endif
