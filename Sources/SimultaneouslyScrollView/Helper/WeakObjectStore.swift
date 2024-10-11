import Foundation

internal class WeakObjectStore<ObjectType: AnyObject> {
    private var internalObjects: [WeakObjectHolder<ObjectType>] = []

    var allObjects: [ObjectType] {
        trimNils()
        return internalObjects.compactMap { $0.object }
    }

    func append(_ object: ObjectType) {
        trimNils()

        guard !contains(object) else { return }

        let weakObjectHolder = WeakObjectHolder(object: object)
        internalObjects.append(weakObjectHolder)
    }

    func remove(_ object: ObjectType) {
        trimNils()

        guard !contains(object) else { return }

        internalObjects.removeAll { $0.object === object }
    }

    func contains(_ object: ObjectType) -> Bool {
        internalObjects.contains { $0.object === object }
    }

    private func trimNils() {
        internalObjects = internalObjects.filter { $0.object != nil }
    }
}

private class WeakObjectHolder<T: AnyObject> {
    private(set) weak var object: T?

    init(object: T) {
        self.object = object
    }
}
