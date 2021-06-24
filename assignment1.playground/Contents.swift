import Foundation
class Item {
    var name : String
    var price : Double
    var quantity : Int
    var tax : Double
    var type : String
    init(name : String,price : Double,quantity : Int,type : String) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.type = type
        self.tax = -9999
    }
    func getTaxBasedOnType() -> Double {
        let taxType = self.type
        let price = self.price
        switch taxType {
        case "raw" :
            self.tax = (12.5 / 100) * price
            
        case "manufactured" :
            self.tax = 12.5 / 100 * price
            self.tax += 2.0 / 100 * (price + self.tax)
            
        case "imported" :
            var tax : Double
            tax = 10.0 / 100 * price;
            if tax <= 100
            {
                    tax += 5;
            } else if tax >= 100 && tax <= 200
            {
                    tax += 10;
            } else
            {
                    // 5 % of final cost which means original price + tax
                    tax += 5.0 / 100 * (tax + price);
            }
            self.tax = tax;
            
        default:
            print("Given type is not supported")
        }
       return self.tax
    }
}
func willdisplayItemsWithTax(items : [Item] ) {
    print("name\t price\t tax\t totalPrice\t type\t ")
    for index in 0..<items.count {
        let item = items[index]
        let tax = item.getTaxBasedOnType()
        if tax != -9999 {
             let totalPrice = tax + item.price
             print("\(item.name)\t \(item.price)\t \(tax)\t \(totalPrice)\t \(item.type)")
        } else {
            print("Warning : Change Type and try again..")
            return
        }

    }
}
func didStartApplication() {
    var items : [Item] = []
    var choice : Character
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
        print("enter the quantity of the product")
        let price : Double = Double(tempPrice) ?? 0.0
        let quantity = Int(readLine(strippingNewline: true) ?? "0") ?? 0
        print("enter the type of product")
        let type = readLine(strippingNewline: true) ?? "raw"
        if type == "" {
            print("Warning : Type can't be nil")
            return
        }
        let currentItem = Item(name : name,price : price,quantity: quantity,type : type)
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

