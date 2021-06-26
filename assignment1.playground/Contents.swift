//@author- Shubhransh Gupta
//23-June 2021
import Foundation
enum itemType {
    case raw
    case imported
    case manufactured
}
class Item {
    var name : String
    var price : Double
    var quantity : Int
    var tax : Double?
    var type : itemType
    init(name : String,price : Double,quantity : Int,type : itemType) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.type = type
        self.tax = nil
    }
    func getTaxBasedOnType() -> Double? {
        switch self.type {
        case itemType.raw :
            self.tax = (12.5 / 100) * self.price
            
        case itemType.manufactured :
            var tax = 12.5 / 100 * self.price
            tax += 2.0 / 100 * (self.price + tax)
            self.tax = tax
        case itemType.imported :
            var tax : Double
            tax = 10.0 / 100 * self.price;
            if tax <= 100
            {
                    tax += 5;
            } else if tax >= 100 && tax <= 200
            {
                    tax += 10;
            } else
            {
                    // 5 % of final cost which means original price + tax
                tax += 5.0 / 100 * (tax + self.price);
            }
            self.tax = tax;
        }
       return self.tax
    }
}
func willdisplayItemsWithTax(items : [Item] ) {
    print("name\t price\t tax\t totalPrice\t type\t ")
    for index in 0..<items.count {
        let item = items[index]
        guard let tax = item.getTaxBasedOnType() else {
            return
        }
        let totalPrice = tax + item.price
        print("\(item.name)\t \(item.price)\t \(tax)\t \(totalPrice)\t \(item.type)\t")
    }
}
func willSetEnumAsPerString(type : String) -> itemType?{
    var response : itemType?
    switch type {
    case "raw": response = itemType.raw
    case "manufactured" : response = itemType.manufactured
    case "imported" :  response = itemType.imported
    default :
        print("Warning : Invalid type \nDisclaimer : We currently support only raw, imported and manufactured type")
        return nil
    }
    return response
}
func didStartApplication() {
    var items : [Item] = []
    var choice : Character
    let flag = 0
    repeat {
        print("---Welcome to the Tax Predictor Application--- \n enter the name of the product")
        guard let name = readLine(strippingNewline: true) else {
        print("Warning : name is nil")
        return
        }
        if name == "" {
            print("Warning : name can't be nil")
            return
        }
        print("enter the price of the product")
        guard let tempPrice = (readLine(strippingNewline: true)) else {
        print("Warning : price is nil")
        return
        }
        let price : Double = Double(tempPrice) ?? Double(flag)
        if price <= Double(flag) {
            print("Warning : Price must be a positive Double")
            return
        }
        print("enter the quantity of the product")
        let quantity = Int(readLine(strippingNewline: true) ?? "0") ?? flag
        if quantity <= flag {
            print("Warning : quantity must be a positive integer greater than zero")
            return
        }
        print("enter the type of product")
        let type = readLine(strippingNewline: true) ?? ""
        if type == "" {
            print("Warning : Type can't be nil")
            return
        }
        let itype = willSetEnumAsPerString(type: type)
        if itype == nil {
            return
        }
        let currentItem = Item(name : name,price : price,quantity: quantity,type : itype ?? itemType.raw)
        items.append(currentItem)
        print("Do you want to add more Items ? (y/n) ")
        let tempChoice = readLine(strippingNewline: true) ?? " "
        if tempChoice == "" {
           choice = "n"
        } else {
            choice = Character(tempChoice)
        }
    } while choice == "y"
    willdisplayItemsWithTax(items : items)
}

didStartApplication()

