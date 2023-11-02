#if os(iOS) || os(tvOS)
import Foundation
import UIKit

internal class ScrollViewDecorator {
    weak var scrollView: UIScrollView?
    var direction: SimultaneouslyScrollViewDirection?

    init(scrollView: UIScrollView, direction: SimultaneouslyScrollViewDirection?) {
        self.scrollView = scrollView
        self.direction = direction
    }
}
#endif
