#if os(iOS) || os(tvOS) || os(visionOS)
import Foundation
import UIKit

internal class ScrollViewDecorator {
    weak var scrollView: UIScrollView?
    var directions: SimultaneouslyScrollViewDirection?
    var delegate: MulticastScrollViewDelegate
    
    init(
        scrollView: UIScrollView,
        directions: SimultaneouslyScrollViewDirection?,
        delegate: MulticastScrollViewDelegate
    ) {
        self.scrollView = scrollView
        self.directions = directions
        self.delegate = delegate
    }
}
#endif
