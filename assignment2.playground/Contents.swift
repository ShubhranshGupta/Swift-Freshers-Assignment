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
//    func sortByAsc(user1 : User,user2 : User) -> Bool{
//        return user1.name < user2.name
//    }
//    func sortByDesc(user1 : User,user2 : User) -> Bool{
//        return user1.name > user2.name
//    }
    func willSortAndPrintUsers(users : [User]) {
        print("Choose an option \n 1- Sort By Name in Ascending \n 2- Sort By Name in Descending \n 3- Sort By RollNo Ascending \n 4- Sort By RollNo Descending")
        guard let tempChoose = (readLine(strippingNewline: true)) else {
            print("Warning : Wrong entry")
            return
        }
        guard let choose = Int(tempChoose) else {
            print("Warning : Wrong entry")
            return
        }
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
        response = "Atleast 4 courses required"
    }
    return response
}
func didTakeInputFromConsole() -> String? {
    guard let input = readLine() else {
        print("Warning : input cannot be nil")
        return nil
    }
    return input
}
func didStartInteract() -> [User]? {
    var users : [User] = []
    var choice : Character
    let flag : Int = 0
    repeat {
    print("Enter the name of User")
    let name = didTakeInputFromConsole() ?? ""
    if name == "" {
        print("Warning : name can't be nil")
        return nil
    }
    print("Enter the age of User")
    let age = Int(didTakeInputFromConsole() ?? "") ?? flag
    if age == flag && age < 1{
        print("Warning : age can't be nil, age must be a +ve number")
        return nil
    }
    print("Enter the address of User")
    let address = didTakeInputFromConsole() ?? ""
    print("Enter the rollNo of User")
    guard let rollNo = Int(didTakeInputFromConsole() ?? "") else {
        print("Warning : rollNo must be a +ve number")
        return nil
    }
    if rollNo < 0 {
        print("Warning : rollNo must be a +ve number")
        return nil
    }
    print("Enter the COURSES opted by User")
    let course = didTakeInputFromConsole() ?? ""
    if course == "" {
        print("Warning : optedCourses can't be nil")
        return nil
    }
    let optedcourse : [String]? = course.split(whereSeparator: {$0 == " "}).map(String.init)
    guard let optcourses = optedcourse  else {
            return nil
    }
    let user = User(name : name,address : address,age : age,rollNo : rollNo,optedCourses : optcourses)
    let response : String? = willCheckAvailability(user : user)
    if response != nil {
        print(response ?? "User should atleast register for 4 courses")
        return nil
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
    guard let users : [User] = didStartInteract() else {
        return
    }
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

