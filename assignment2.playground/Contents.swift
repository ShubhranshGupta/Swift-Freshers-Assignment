// @author - Shubhransh Gupta
// 23- June- 2021

import Foundation
class User {
    var name : String
    var address : String
    var age : Int
    var rollNo : Int
    var optedCourses : [String] = []
    
    init(name : String,address : String,age : Int,rollNo : Int,optedCourses : [String]) {
        self.name = name
        self.address = address
        self.age = age
        self.rollNo = rollNo
        self.optedCourses = optedCourses
    }
}
class UserManager {
    func sortByAsc(user1 : User,user2 : User) -> Bool{
        return user1.name < user2.name
    }
    func sortByDesc(user1 : User,user2 : User) -> Bool{
        return user1.name > user2.name
    }

    func willSortAndPrintUsers(users : [User]) {
        var choose : Int
        print("Choose an option \n 1- Sort By Name in Ascending \n 2- Sort By Name in Descending \n 3- Sort By RollNo Ascending \n 4- Sort By RollNo Descending")
        choose = Int(readLine(strippingNewline: true)!)!
        if choose == 1
        {
            willDisplayUsers(users : users.sorted(by: { $0.name > $1.name }))
        } else if choose == 2 {
            willDisplayUsers(users : users.sorted(by: { $0.name < $1.name }))
        } else if choose == 3 {
            willDisplayUsers(users : users.sorted(by: { $0.rollNo > $1.rollNo }))
        } else if choose == 4 {
            willDisplayUsers(users : users.sorted(by: { $0.rollNo < $1.rollNo }))
        }
    }
    func willDisplayUsers(users : [User]) {
        print("Name\t Age\t RollNo\t Address\t OptedCourses")
        for index in 0..<users.count {
            let user = users[index]
            print("\(user.name)\t\(user.age)\t\(user.rollNo)\t\(user.address)\t\(user.optedCourses)\t")
        }
    }
}
func willCheckAvailability(user : User) -> String? {
    var response : String?
    if (user.optedCourses.count) > 3 {
        return nil
    } else {
        response?.append("Atleast 4 courses required")
    }
    return response
}
func didTakeInputFromConsole() -> String? {
    guard let input = readLine() else {
        print("Warning : input cannot be Null")
        return nil
    }
    return input
}
func didStartInteract() -> [User] {
    var users : [User] = []
    var choice : Character
    repeat {
    print("Enter the name of User")
    let name = didTakeInputFromConsole() ?? ""
    if name == "" {
        print("Warning : name can't be nil")
        exit(0)
    }
    print("Enter the age of User")
    let age = Int(didTakeInputFromConsole() ?? "0") ?? 0
    if age == 0 {
        print("Warning : age can't be nil, age must be a +ve number")
        exit(0)
    }
    print("Enter the address of User")
    let address = didTakeInputFromConsole() ?? ""
    print("Enter the rollNo of User")
    let rollNo = Int(didTakeInputFromConsole() ?? "") ?? -1
    if rollNo == -1 {
        print("Warning : rollNo must be a +ve number")
        exit(0)
    }
    print("Enter the COURSES opted by User")
    let course = didTakeInputFromConsole() ?? ""
    if course == "" {
        print("Warning : optedCourses can't be nil")
        exit(0)
    }
    let optedcourse : [String]! = course.split{$0 == " "}.map(String.init)
    let user = User(name : name,address : address,age : age,rollNo : rollNo,optedCourses : optedcourse)
    let response : String? = willCheckAvailability(user : user)
    if response != nil {
        print(response ?? "User should atleast register for 4 courses")
        exit(0)
    }
    users.append(user)
    print("Do you want to add more Users ? (y/n) ")
    let tempChoice = readLine(strippingNewline: true) ?? " "
    if tempChoice == "" {
        choice = "n"
    } else {
        choice = Character(tempChoice)
    }
    } while choice == "y"
    return users
}
func didStartApplication() {
    print("--Welcome to the User Application--")
    var choice : Int
    var users : [User] = []
    users = didStartInteract()
    let userManager = UserManager()
    var keepinloop : Character
    repeat {
    print("Select any feature to continue \n 1-Display details \n 2-Sorted view of DB")
    choice = Int(readLine(strippingNewline: true) ?? "") ?? 3
    switch choice {
    case 1 : userManager.willDisplayUsers(users : users)
    case 2 : userManager.willSortAndPrintUsers(users : users)
    default : print("Warning : Invalid entry \n Try Again")
    }
    print("Do you want to continue the Application ? (y/n) ")
    let tempChoice = readLine(strippingNewline: true) ?? " "
    if tempChoice == "" {
        keepinloop = "n"
    } else {
        keepinloop = Character(tempChoice)
    }
    } while keepinloop == "y"
}
didStartApplication()
