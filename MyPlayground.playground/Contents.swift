import UIKit

let enUS = Locale(identifier: "en-US")
let formatter = NumberFormatter()
formatter.numberStyle = .currency
formatter.locale = Locale.current
formatter.string(from: 20000)!

let formatter2 = NumberFormatter()
formatter2.numberStyle = .decimal
formatter2.locale = Locale.current
formatter2.string(from: 20000)!


Locale.current
Locale.current.identifier
Locale.current.languageCode
Locale.current.region
Locale.current.currencySymbol
Locale(identifier: "en-US").currencySymbol

func localizedPrice() -> String {

    

    
    
    return formatter.string(from: 20000)!
}
