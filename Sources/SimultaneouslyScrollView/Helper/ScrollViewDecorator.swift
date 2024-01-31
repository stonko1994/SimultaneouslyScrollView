#if os(iOS) || os(tvOS) || os(visionOS)
import Foundation
import UIKit

internal class ScrollViewDecorator {
    weak var scrollView: UIScrollView?
    var directions: SimultaneouslyScrollViewDirection?

    init(scrollView: UIScrollView, directions: SimultaneouslyScrollViewDirection?) {
        self.scrollView = scrollView
        self.directions = directions
    }
}
#endif
