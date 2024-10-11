#if os(iOS) || os(tvOS) || os(visionOS)

import UIKit

internal class MulticastScrollViewDelegate: NSObject, UIScrollViewDelegate {
    private var delegates = WeakObjectStore<UIScrollViewDelegate>()

    func addDelegate(_ delegate: UIScrollViewDelegate) {
        delegates.append(delegate)
    }

    func removeDelegate(_ delegate: UIScrollViewDelegate) {
        delegates.remove(delegate)
    }
    
    func callAll(_ closure: (_ delegate: UIScrollViewDelegate) -> ()) {
        delegates.allObjects.forEach(closure)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        callAll { $0.scrollViewDidScroll?(scrollView) }
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        callAll { $0.scrollViewDidZoom?(scrollView) }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        callAll { $0.scrollViewWillBeginDragging?(scrollView) }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let originalTargetContentOffset = targetContentOffset.pointee
        var proposedOffsets: [CGPoint] = []
        
        for delegate in delegates.allObjects {
            targetContentOffset.pointee = originalTargetContentOffset
            delegate.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
            proposedOffsets.append(targetContentOffset.pointee)
        }
        
        let offsetProposals = proposedOffsets.filter { $0 != originalTargetContentOffset }
        assert(offsetProposals.count <= 1, "Multiple delegates returned a custom targetContentOffset. Only one delegate may return a targetContentOffset.")
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        callAll { $0.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate) }
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        callAll { $0.scrollViewWillBeginDecelerating?(scrollView) }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        callAll { $0.scrollViewDidEndDecelerating?(scrollView) }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        callAll { $0.scrollViewDidEndScrollingAnimation?(scrollView) }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        let views = delegates.allObjects.compactMap { $0.viewForZooming?(in: scrollView) }
        assert(views.count <= 1, "Multiple delegates returned a view for zooming. Only one delegate may return a view.")
        return views.first
    }

    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        callAll { $0.scrollViewWillBeginZooming?(scrollView, with: view) }
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        callAll { $0.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale) }
    }

    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        delegates.allObjects
            .compactMap { $0.scrollViewShouldScrollToTop?(scrollView) }
            .reduce(true, { $0 && $1 })
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        callAll { $0.scrollViewDidScrollToTop?(scrollView) }
    }

    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        callAll { $0.scrollViewDidChangeAdjustedContentInset?(scrollView) }
    }
}
#endif
