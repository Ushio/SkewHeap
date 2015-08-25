//
//  main.swift
//  SkewHeap
//
//  Created by Ushio on 2015/07/22.
//  Copyright © 2015年 Ushio. All rights reserved.
//

import Foundation

enum SkewHeap<T: Comparable> {
    case Nil
    indirect case Node(value: T, left: SkewHeap<T>, right: SkewHeap<T>)
}

func merge<T: Comparable>(var lhs: SkewHeap<T>, var _ rhs: SkewHeap<T>) -> SkewHeap<T> {
    guard case var .Node(lhsNode)  = lhs else {
        return rhs
    }
    guard case var .Node(rhsNode)  = rhs else {
        return lhs
    }
    if lhsNode.value > rhsNode.value {
        swap(&lhs, &rhs)
        swap(&lhsNode, &rhsNode)
    }
    return .Node(value: lhsNode.value, left: merge(lhsNode.right, rhs), right: lhsNode.left)
}
extension SkewHeap {
    init() {
        self = .Nil
    }
    init(_ value: T) {
        self = .Node(value: value, left: .Nil, right: .Nil)
    }
}
extension SkewHeap {
    var min: T? {
        guard case let .Node(node)  = self else {
            return nil
        }
        return node.value
    }
    func push(value: T) -> SkewHeap {
        return merge(self, SkewHeap(value))
    }
    var pop: SkewHeap {
        guard case let .Node(node)  = self else {
            return .Nil
        }
        return merge(node.left, node.right)
    }
}

var heap = SkewHeap(4).push(1).push(3).push(2).push(5)
while let min = heap.min {
    print(min)
    heap = heap.pop
}

/*
1
2
3
4
5
*/


