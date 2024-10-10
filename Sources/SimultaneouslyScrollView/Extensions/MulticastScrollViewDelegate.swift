import UIKit;

class MulticastScrollViewDelegate: NSObject, UIScrollViewDelegate {
    // Store weak references to delegates
    private var delegates = NSHashTable<UIScrollViewDelegate>.weakObjects()

    func addDelegate(_ delegate: UIScrollViewDelegate) {
        delegates.add(delegate)
    }

    func removeDelegate(_ delegate: UIScrollViewDelegate) {
        delegates.remove(delegate)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for delegate in delegates.allObjects {
            delegate.scrollViewDidScroll?(scrollView)
        }
    }
    

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        for delegate in delegates.allObjects {
            delegate.scrollViewDidZoom?(scrollView)
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        for delegate in delegates.allObjects {
            delegate.scrollViewWillBeginDragging?(scrollView)
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        for delegate in delegates.allObjects {
            delegate.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        for delegate in delegates.allObjects {
            delegate.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
        }
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        for delegate in delegates.allObjects {
            delegate.scrollViewWillBeginDecelerating?(scrollView)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for delegate in delegates.allObjects {
            delegate.scrollViewDidEndDecelerating?(scrollView)
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        for delegate in delegates.allObjects {
            delegate.scrollViewDidEndScrollingAnimation?(scrollView)
        }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        for delegate in delegates.allObjects {
            if let view = delegate.viewForZooming?(in: scrollView) {
                return view
            }
        }
        return nil
    }

    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        for delegate in delegates.allObjects {
            delegate.scrollViewWillBeginZooming?(scrollView, with: view)
        }
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        for delegate in delegates.allObjects {
            delegate.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
        }
    }

    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        for delegate in delegates.allObjects {
            if let shouldScrollToTop = delegate.scrollViewShouldScrollToTop?(scrollView) {
                return shouldScrollToTop
            }
        }
        return true
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        for delegate in delegates.allObjects {
            delegate.scrollViewDidScrollToTop?(scrollView)
        }
    }

    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        if #available(iOS 11.0, *) {
            for delegate in delegates.allObjects {
                delegate.scrollViewDidChangeAdjustedContentInset?(scrollView)
            }
        }
    }
}
