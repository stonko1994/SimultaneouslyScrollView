#if os(iOS) || os(tvOS) || os(visionOS)
import Combine
import UIKit

internal class DefaultSimultaneouslyScrollViewHandler: NSObject, SimultaneouslyScrollViewHandler {
    private var scrollViewsStore: [ScrollViewDecorator] = []
    private weak var lastScrollingScrollView: UIScrollView?

    private let scrolledToBottomSubject = PassthroughSubject<Bool, Never>()

    var scrolledToBottomPublisher: AnyPublisher<Bool, Never> {
        scrolledToBottomSubject.eraseToAnyPublisher()
    }

    func register(scrollView: UIScrollView) {
        register(scrollView: scrollView, scrollDirections: nil)
    }

    func register(scrollView: UIScrollView, scrollDirections: SimultaneouslyScrollViewDirection?) {
        guard !scrollViewsStore.contains(where: { $0.scrollView == scrollView }) else {
            return
        }

        scrollView.delegate = self
        scrollViewsStore.append(
            ScrollViewDecorator(
                scrollView: scrollView,
                directions: scrollDirections
            )
        )

        // Scroll the new `ScrollView` to the current position of the others.
        // Using the first `ScrollView` should be enough as all should be synchronized at this point already.
        guard let decorator = scrollViewsStore.first else {
            return
        }

        sync(scrollView: scrollView, with: decorator)

        checkIsContentOffsetAtBottom()
    }

    func scrollAllToBottom(animated: Bool) {
        guard !scrollViewsStore.isEmpty,
              let scrollView = scrollViewsStore.first?.scrollView,
              scrollView.hasContentToFillScrollView
        else {
            return
        }

        let bottomContentOffset = CGPoint(
            x: 0,
            y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom
        )

        scrollViewsStore
            .compactMap { $0.scrollView }
            .forEach { $0.setContentOffset(bottomContentOffset, animated: animated) }
    }

    private func checkIsContentOffsetAtBottom() {
        guard !scrollViewsStore.isEmpty,
              let scrollView = scrollViewsStore.first?.scrollView,
              scrollView.hasContentToFillScrollView
        else {
            scrolledToBottomSubject.send(true)
            return
        }

        if scrollView.isAtBottom {
            scrolledToBottomSubject.send(true)
        } else {
            scrolledToBottomSubject.send(false)
        }
    }

    private func sync(scrollView: UIScrollView, with decorator: ScrollViewDecorator) {
        guard let registeredScrollView = decorator.scrollView else {
            return
        }

        switch decorator.directions {
        case [.horizontal]:
            let offset = CGPoint(x: scrollView.contentOffset.x, y: registeredScrollView.contentOffset.y)
            registeredScrollView.setContentOffset(offset, animated: false)
        case [.vertical]:
            let offset = CGPoint(x: registeredScrollView.contentOffset.x, y: scrollView.contentOffset.y)
            registeredScrollView.setContentOffset(offset, animated: false)
        default:
            registeredScrollView.setContentOffset(scrollView.contentOffset, animated: false)
        }
    }
}

extension DefaultSimultaneouslyScrollViewHandler: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastScrollingScrollView = scrollView
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        checkIsContentOffsetAtBottom()

        guard lastScrollingScrollView == scrollView else {
            return
        }

        scrollViewsStore
            .filter { $0.scrollView != lastScrollingScrollView }
            .forEach { sync(scrollView: scrollView, with: $0) }
    }
}
#endif
