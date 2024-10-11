#if os(iOS) || os(tvOS) || os(visionOS)
import Foundation
import UIKit

internal class ScrollViewDecorator {
    weak var scrollView: UIScrollView?
    var delegate: MulticastScrollViewDelegate
    var directions: SimultaneouslyScrollViewDirection?

    init(
        scrollView: UIScrollView,
        delegate: MulticastScrollViewDelegate,
        directions: SimultaneouslyScrollViewDirection?
    ) {
        self.scrollView = scrollView
        self.delegate = delegate
        self.directions = directions
    }
}
#endif
