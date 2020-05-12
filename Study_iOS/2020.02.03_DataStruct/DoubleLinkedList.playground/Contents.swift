import UIKit

/***************************************************
 Node
 ***************************************************/

final class Node {
  let value: String
  weak var previous: Node?
  var next: Node?
  
  init(value: String) {
    self.value = value
  }
  deinit {
    print("\(value) Node has deinitialized")
  }
}


/***************************************************
 DoubleLinkedList
 ***************************************************/

final class DoubleLinkedList {
  private var head: Node?
  private weak var tail: Node?
  
  var first: Node? { return head }
  var last: Node?  { return tail }
  var isEmpty: Bool { return head == nil }
  var count: Int {
    guard var node = head else { return 0 }
    
    var count = 1
    while let nextNode = node.next {
      count += 1
      node = nextNode
    }
    return count
  }
  
  func append(node: Node) {
    if let tailNode = tail {
      tailNode.next = node
      node.previous = tailNode
    } else {
      head = node
    }
    tail = node
  }
  
  func insert(node newNode: Node, at index: Int) {
    var node = head
    for _ in 0..<index {
      node = node?.next
    }
    guard node != nil else { return print("인덱스 오류") }
    
    newNode.previous = node?.previous
    newNode.next = node
    node?.previous?.next = newNode
    node?.previous = newNode
  }
  
  func node(at index: Int) -> Node? {
    var node = head
    for _ in 0..<index {
      node = node?.next
    }
    return node
  }
  
  func node(by value: String) -> Node? {
    var node = head
    while node?.value != value {
      node = node?.next
    }
    return node
  }
  
  func remove(at index: Int) -> String? {
    guard let node = node(at: index) else { return nil }
    
    if node === head {
      head = node.next
    } else if node === tail {
      tail = node.previous
    }
    node.previous?.next = node.next
    node.next?.previous = node.previous
    
    return node.value
  }
  
  func removeNode(by value: String) -> Bool {
    guard let node = node(by: value) else { return false }
    
    if node === head {
      head = node.next
    } else if node === tail {
      tail = node.previous
    }
    node.previous?.next = node.next
    node.next?.previous = node.previous
    
    return true
  }
  
  func removeAll() {
    head = nil
    tail = nil
  }
  
  func scanValues() {
    var values: [String] = []
    var node = head
    
    while let _ = node {
      values.append(node!.value)
      node = node!.next
    }
    print("Values :", values)
  }
}




var nodes: [Node] = [
  Node(value: "A"), Node(value: "B"), Node(value: "C"), Node(value: "D")
]

print("\n---------- [ LinkedList Initialize ] ----------\n")
let linkedList = DoubleLinkedList()
linkedList.isEmpty

linkedList.insert(node: Node(value: "A"), at: 10)
linkedList.scanValues()


nodes.forEach(linkedList.append(node:))
nodes.removeAll()
linkedList.scanValues()

linkedList.count
linkedList.first!.value
linkedList.last!.value
linkedList.isEmpty

print("\n---------- [ New Nodes (E, F, G) ] ----------\n")
linkedList.append(node: Node(value: "E"))
linkedList.insert(node: Node(value: "F"), at: 1)
linkedList.insert(node: Node(value: "G"), at: 5)
linkedList.scanValues()

linkedList.count
linkedList.first!.value
linkedList.last!.value

print("\n---------- [ Remove Node at 6 ] ----------\n")
linkedList.node(at: 6)?.value ?? "nil"
linkedList.remove(at: 6) ?? ""
linkedList.scanValues()

print("\n---------- [ Remove Node Value B ] ----------\n")
linkedList.node(by: "B")?.value ?? ""
linkedList.removeNode(by: "B")
linkedList.scanValues()

print("\n---------- [ removeAll ] ----------\n")
linkedList.removeAll()
linkedList.isEmpty


