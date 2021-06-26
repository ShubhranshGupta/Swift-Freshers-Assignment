import Foundation
//individual nodes
class Node {
    var nodeId : Int
    var nodeName : String
    var parents = Set<Int>()
    var children = Set<Int>()
    init(nodeId : Int,nodeName : String) {
        self.nodeId = nodeId
        self.nodeName = nodeName
    }
    func setParent(parentId : Int) {
        if self.parents.contains(parentId) == true {
            print("Already a Parent")
            return
        }
        self.parents.insert(parentId)
    }
    func setChildren(childId : Int) {
        if self.children.contains(childId) == true {
            print("Already a child")
            return
        }
        self.children.insert(childId)
    }
    func deleteParent(parentId : Int) {
        if self.parents.contains(parentId) == true {
            self.parents.remove(parentId)
            return
        }
        print("Not a Parent of this node")
    }
    func deleteChildren(childId : Int) {
        if self.children.contains(childId) == true {
            self.children.remove(childId)
            return
        }
        print("Not a Child of this node")
    }
}
//operations
class DependencyGraph {

    func getNodeAndIndexFromNodeList(nodeId : Int,nodeList : [Node]) -> (node: Node?,index : Int) {
        for index in 0..<nodeList.count {
            if nodeList[index].nodeId == nodeId {
                return (nodeList[index],index)
            }
        }
        return (nil,-1)
    }
    func willdisplayGraph(nodeList : [Node]) {
        for index in 0..<nodeList.count {
            print(nodeList[index].nodeId)
        }
    }
    func getParents(nodeId : Int,nodeList : [Node]) {
        let currentNode = getNodeAndIndexFromNodeList(nodeId: nodeId,nodeList : nodeList)
        guard let node = currentNode.node else {
            print("Node doesn't exist")
            return
        }
        print("All Parents for given node are -> \(node.parents)")
    }
    func getChildren(nodeId : Int,nodeList : [Node]) {
        let currentNode = getNodeAndIndexFromNodeList(nodeId: nodeId,nodeList : nodeList)
        guard let node = currentNode.node else {
            print("Node doesn't exist")
            return
        }
        print("All Children for given node are -> \(node.children)")
    }
    func addDependency(parentId: Int,childId : Int,nodeList : [Node]) {
        let parentNode = getNodeAndIndexFromNodeList(nodeId: parentId,nodeList : nodeList)
        guard let pnode = parentNode.node else {
            print("Parent Node doesn't exist")
            return
        }
        pnode.setChildren(childId : childId)
        let childNode = getNodeAndIndexFromNodeList(nodeId: childId,nodeList : nodeList)
        guard let cnode = childNode.node else {
            print("Child Node doesn't exist")
            return
        }
        cnode.setParent(parentId : parentId)
    }
    func deleteDependency(parentId: Int,childId : Int,nodeList : [Node]) {
        let parentNode = getNodeAndIndexFromNodeList(nodeId: parentId,nodeList : nodeList)
        guard let pnode = parentNode.node else {
            print("Parent Node doesn't exist")
            return
        }
        pnode.deleteChildren(childId : childId)
        let childNode = getNodeAndIndexFromNodeList(nodeId: childId,nodeList : nodeList)
        guard let cnode = childNode.node else {
            print("Child Node doesn't exist")
            return
        }
        cnode.deleteParent(parentId : parentId)
    }
    func getAncestors(nodeId : Int,nodeList : [Node]) {
        let currentNode = getNodeAndIndexFromNodeList(nodeId: nodeId,nodeList : nodeList)
        guard let node = currentNode.node else {
            print("Node doesn't exist")
            return
        }
//        print("\t \t \(node.nodeId)")
        for parent in node.parents {
            print("\t \t ^")
            print("\t \t |")
            print("\t \t \(parent)")
            let parentNode = getNodeAndIndexFromNodeList(nodeId: parent,nodeList : nodeList)
            guard let ancestors = parentNode.node?.parents else {
                continue
            }
            print("\t \t ^")
            print("\t \t |")

            print("\t \t \(ancestors)")
        }
        
    }
    func getDescendants(nodeId : Int,nodeList : [Node]) {
        let currentNode = getNodeAndIndexFromNodeList(nodeId: nodeId,nodeList : nodeList)
        guard let node = currentNode.node else {
            print("Node doesn't exist")
            return
        }
//        print("\t \t \(node.nodeId)")
        for child in node.children {
            print("\t \t |")
            print("\t \t V")
            print("\t \t \(child)")
            let childNode = getNodeAndIndexFromNodeList(nodeId: child,nodeList : nodeList)
            guard let descendants = childNode.node?.children else {
            continue
            }
            print("\t \t |")
            print("\t \t V")
            print("\t \t \(descendants)")
        }
    }
}
func willTakeNodeIdFromConsole() -> Int? {
    print("Enter the Node ID")
    guard let Id = (readLine(strippingNewline: true)) else {
      print("Warning : Node ID can't be nil")
      return nil
    }
    guard let nodeId = Int(Id) else {
        print("Warning : Node Id can't be nil")
        return nil
    }
    return nodeId
}
func willTakeNameFromConsole() -> String? {
    print("Enter the Node Name")
    guard let name = readLine(strippingNewline: true) else {
    print("Warning : Node name can't be nil")
    return nil
    }
    if name == "" {
        print("Warning : name can't be nil")
        return nil
    }
    return name
}
func didStartApplication() {
    let flag = -1
    var choice : Character
    var nodeList : [Node] = []
    let dependencyGraph = DependencyGraph()
    repeat {
        var input : Int
        print("----Welcome----");
        print("1. Add node to a tree");
        print("2. Delete a node from a tree");
        print("3. Get ancestors of a node");
        print("4. Get descendants of a node");
        print("5. Delete dependency from Graph");
        print("6. Add dependency to Graph");
        print("7. Exit");
        print("Choose any one option");
        input = Int(readLine(strippingNewline: true) ?? "7") ?? 7
        switch input {
        case 1 :
            guard let nodeId = willTakeNodeIdFromConsole() else {
                return
            }
            guard let nodeName = willTakeNameFromConsole() else {
                return
            }
            nodeList.append(Node(nodeId: nodeId, nodeName: nodeName))
            print("Node added sucessfully")
            dependencyGraph.willdisplayGraph(nodeList: nodeList)
        case 2 :
            guard let nodeId = willTakeNodeIdFromConsole() else {
                return
            }
            let currentNode = dependencyGraph.getNodeAndIndexFromNodeList(nodeId: nodeId,nodeList : nodeList)
            if currentNode.node != nil {
                guard let tempChild = currentNode.node?.children else {
                    break
                }
                guard let tempParent = currentNode.node?.parents else {
                    break
                }
                for id in tempParent {
                    dependencyGraph.deleteDependency(parentId: id, childId: currentNode.node?.nodeId ?? 0, nodeList: nodeList)
                }
                for id in tempChild {
                    dependencyGraph.deleteDependency(parentId: currentNode.node?.nodeId ?? 0, childId: id, nodeList: nodeList)
                }
                nodeList.remove(at : currentNode.index)
                print("Node deleted successfully")
            } else if currentNode.index == flag {
                print("Node doesnt exist in Dependency Graph")
            }
        case 3 :
            guard let nodeId = willTakeNodeIdFromConsole() else {
                return
            }
            dependencyGraph.getAncestors(nodeId: nodeId,nodeList : nodeList)
        case 4 :
            guard let nodeId = willTakeNodeIdFromConsole() else {
                return
            }
            dependencyGraph.getDescendants(nodeId: nodeId,nodeList : nodeList)
        case 5 :
            print("Enter parent and childID respectively")
            guard let parentId = willTakeNodeIdFromConsole() else {
                return
            }
            guard let childId = willTakeNodeIdFromConsole() else{
                return
            }
            dependencyGraph.deleteDependency(parentId: parentId, childId: childId,nodeList : nodeList)
        case 6 :
            print("Enter parent and childID respectively")
            guard let parentId = willTakeNodeIdFromConsole() else {
                return
            }
            guard let childId = willTakeNodeIdFromConsole() else {
                return
            }
            dependencyGraph.addDependency(parentId: parentId, childId: childId,nodeList : nodeList)
        case 7 :
            break
        default :
            print("Invalid Entry")
            break
        }
        print("Do you want to terminate this application ? (y/n) ")
        let tempChoice = readLine(strippingNewline: true) ?? " "
        if tempChoice == "" {
           choice = "y"
        } else {
            choice = Character(tempChoice)
        }
    } while choice == "n"
}
didStartApplication()


