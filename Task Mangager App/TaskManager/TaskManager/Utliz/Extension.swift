////

import Foundation
import UIKit


extension UIView {

    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidthV1: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColorV1: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

//    func combineAdress(_ user: User) -> String {
//        var adress = ""
//        if user.city != "" {
//            adress = user.city
//            return adress
//        }
//        if user.state != "" {
//            adress = user.state
//            return adress
//        }
//        if user.country != "" {
//            adress = user.country
//            return adress
//        }
//        if adress == "" {
//            return "No address."
//        }
//        return adress
//    }
//     func getAgeFromDOB(_ DOB: String) -> String
    func getAgeFromDOB(_ dob : String) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let date = df.date(from: dob)
        guard let val = date else{
//            return (0, 0, 0)
            return "0"
        }
        var years = 0
        var months = 0
        var days = 0

        let cal = NSCalendar.current
        years = cal.component(.year, from: NSDate() as Date) -  cal.component(.year, from: val)

        let currMonth = cal.component(.month, from: NSDate() as Date)
        let birthMonth = cal.component(.month, from: val)

        //get difference between current month and birthMonth
        months = currMonth - birthMonth
        //if month difference is in negative then reduce years by one and calculate the number of months.
        if months < 0
        {
            years = years - 1
            months = 12 - birthMonth + currMonth
            if cal.component(.day, from: NSDate() as Date) < cal.component(.day, from: val){
                months = months - 1
            }
        } else if months == 0 && cal.component(.day, from: NSDate() as Date) < cal.component(.day, from: val)
        {
            years = years - 1
            months = 11
        }

        //Calculate the days
        if cal.component(.day, from: NSDate() as Date) > cal.component(.day, from: val){
            days = cal.component(.day, from: NSDate() as Date) - cal.component(.day, from: val)
        }
        else if cal.component(.day, from: NSDate() as Date) < cal.component(.day, from: val)
        {
            let today = cal.component(.day, from: NSDate() as Date)
//            let date = cal.dateByAddingUnit(.Month, value: -1, toDate: NSDate(), options: [])
            let date = cal.date(byAdding: .month, value: -1, to: NSDate() as Date)

            days = (cal.component(.day, from: date!) - cal.component(.day, from: val)) + today
        } else
        {
            days = 0
            if months == 12
            {
                years = years + 1
                months = 0
            }
        }

        print("Years: \(years), Months: \(months), Days: \(days)")
        return years > 1 ? "\(years)" : "0"
//        return "\(years)"
    }

    func dropShadow(color: UIColor, opacity: Float = 0.3, offSet: CGSize = CGSize(width: 0.5, height: 0.5), radius: CGFloat = 6, scale: Bool = true) {
//        self.layer.masksToBounds = false
//          self.layer.shadowColor = color.cgColor
//          self.layer.shadowOpacity = opacity
//        self.layer.shadowOffset = offSet
//          self.layer.shadowRadius = radius
//          self.layer.cornerRadius = radius
//         // self.clipsToBounds = true
//          self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//          self.layer.shouldRasterize = false
//          self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        
//        self.layer.cornerRadius = radius
//        self.clipsToBounds = true
//        self.layer.shadowRadius = 10
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowOffset = CGSize(width: 3, height: 3)
//        self.layer.shadowColor = UIColor(named: "lightBlue")!.cgColor
//        self.layer.masksToBounds = false
        
        self.clipsToBounds = false // Allow the shadow to extend beyond the bounds
        
        // Add a shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4.0
        
        
      }

}
//
//extension UILabel {
//
//
//    @IBInspectable var localizedString: String? {
//        get {
//            return text
//        } set {
//            text = getLangText(string: newValue ?? "")
//        }
//    }
//
//    @IBInspectable var adjustSize: Bool {
//        get {
//            return adjustsFontSizeToFitWidth
//        }
//        set {
//            adjustsFontSizeToFitWidth = newValue
//        }
//    }
//}

//extension UIButton {
//
//
//    @IBInspectable var localizedString: String? {
//        get {
//            return title(for: .normal)
//        } set {
//            titleLabel?.text = getLangText(string: newValue ?? "")
//        }
//    }
//}

//@IBDesignable class LocalizableButton: UIButton {
//
//    @IBInspectable var localizeString:String = "" {
//        didSet {
//            self.setTitle(getLangText(string: localizeString), for: .normal)
//            /*#if TARGET_INTERFACE_BUILDER
//                var bundle = NSBundle(forClass: self.dynamicType)
//                self.setTitle(bundle.localizedStringForKey(self.localizeString, value:"", table: nil), forState: UIControlState.Normal)
//            #else
//            self.setTitle(getLangText(string: localizeString), for: .normal)
//            #endif*/
//        }
//    }
//
//}


@IBDesignable
class Shadow : UIButton {
    @IBInspectable var shadowColor: UIColor = UIColor.black {
         didSet {
             self.addShadow()
         }
     }

    func addShadow(){
          let radius: CGFloat = frame.width / 2.3 //change it to .height if you need spread for height
         let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 5, width: 2.15 * radius, height: frame.height))
         //Change 2.1 to amount of spread you need and for height replace the code for height

         layer.cornerRadius = 15
         layer.shadowColor = UIColor(red: 114/255, green: 99/255, blue: 255/255, alpha: 1).cgColor // UIColor.darkGray.cgColor
         layer.shadowOffset = CGSize(width: 0.5, height: 0.5)  //Here you control x and y
         layer.shadowOpacity = 0.1
         layer.shadowRadius = 2.0 //Here your control your blur
         layer.masksToBounds =  false
         layer.shadowPath = shadowPath.cgPath
        // layer.cornerRadius = 13
      }
}
@IBDesignable
class ShadowDrop : UIView {
    @IBInspectable var shadowColor: UIColor = UIColor.black {
         didSet {
             self.addShadow()
         }
     }

    func addShadow(){
          let radius: CGFloat = frame.width / 2 //change it to .height if you need spread for height
         let shadowPath = UIBezierPath(rect: CGRect(x: -5, y: 5, width: 2.2 * radius, height: frame.height))
         //Change 2.1 to amount of spread you need and for height replace the code for height

          layer.cornerRadius = 15
        layer.shadowColor =  UIColor.darkGray.cgColor  //UIColor(red: 114/255, green: 99/255, blue: 255/255, alpha: 1).cgColor
        layer.shadowOffset = CGSize(width: 0.3, height: 0.1)  //Here you control x and y
         layer.shadowOpacity = 0.15
         layer.masksToBounds =  false
         layer.shadowPath = shadowPath.cgPath
         layer.cornerRadius = 20
          layer.shadowRadius = 10.0 //Here your control your blur

      }
}
extension UIView {
    func addDropShadow(){
          let radius: CGFloat = frame.width / 2 //change it to .height if you need spread for height
         let shadowPath = UIBezierPath(rect: CGRect(x: -8, y: 5, width: 2.2 * radius, height: frame.height))
         //Change 2.1 to amount of spread you need and for height replace the code for height

          layer.cornerRadius = 15
        layer.shadowColor =  UIColor.darkGray.cgColor  //UIColor(red: 114/255, green: 99/255, blue: 255/255, alpha: 1).cgColor
         layer.shadowOffset = CGSize(width: 0.3, height: 0.5)  //Here you control x and y
         layer.shadowOpacity = 0.15
         layer.masksToBounds =  false
         layer.shadowPath = shadowPath.cgPath
         layer.cornerRadius = 20
          layer.shadowRadius = 10.0 //Here your control your blur

      }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    func shortToken() -> String {
       return "(\(self.prefix(5))...\(self.suffix(4)) )"
    }
}
extension UserDefaults {

   func save<T:Encodable>(customObject object: T, inKey key: String) {
       let encoder = JSONEncoder()
       if let encoded = try? encoder.encode(object) {
           self.set(encoded, forKey: key)
       }
   }

   func retrieve<T:Decodable>(object type:T.Type, fromKey key: String) -> T? {
       if let data = self.data(forKey: key) {
           let decoder = JSONDecoder()
           if let object = try? decoder.decode(type, from: data) {
               return object
           }else {
               print("Couldnt decode object")
               return nil
           }
       }else {
           print("Couldnt find key")
           return nil
       }
   }

}
extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
extension Encodable {
    var dictionary: [String: Any]? {
      guard let data = try? JSONEncoder().encode(self) else { return nil }
      return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
  }
extension UIViewController {
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
    func alertWithAction(message: String, title: String = "", okCompletion: @escaping (()->()), cancelCompletion: @escaping (()->())  ) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Yes", style: .default) { act in
            okCompletion()
        }
        
        let cancel = UIAlertAction(title: "No", style: .default) { act in
            cancelCompletion()
        }
        
      alertController.addAction(OKAction)
        alertController.addAction(cancel)
      self.present(alertController, animated: true, completion: nil)
    }
    
    func alertWithSignleAction(message: String, title: String = "", okCompletion: @escaping (()->()) ) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok", style: .default) { act in
            okCompletion()
        }
        
      alertController.addAction(OKAction)
      self.present(alertController, animated: true, completion: nil)
    }
    
    func backTwo(vc: Int) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - vc], animated: true)
    }
}

extension UIAlertController {
    func withCloseButton() -> UIAlertController {
        addAction(UIAlertAction(title: "Close", style: .cancel))
        return self
    }
    
    func withActionButton() -> UIAlertController {
        addAction(UIAlertAction(title: "Install", style: .default, handler: { UIAlertAction in
            if let url = URL(string: "itms-apps://apple.com/app/id1438144202") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        return self
    }

    static func showFailedToConnect(from controller: UIViewController) {
        let alert = UIAlertController(title: "Failed to connect", message: nil, preferredStyle: .alert)
        controller.present(alert.withCloseButton(), animated: true)
    }
    
    static func showInstallApp(from controller: UIViewController) {
        let alert = UIAlertController(title: "Wallet Not Found", message: "You need to install Metamask app from the app store", preferredStyle: .alert)
        controller.present(alert.withActionButton(), animated: true)
    }

    static func showDisconnected(from controller: UIViewController) {
        let alert = UIAlertController(title: "Did disconnect", message: nil, preferredStyle: .alert)
        controller.present(alert.withCloseButton(), animated: true)
    }
}
extension String {

    func toDate(withFormat format: String = "MM/dd/yyyy")-> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date ?? Date()

    }
    
    func changeDateFormat() ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if   let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MM, dd, yyyy"
            let resultString = dateFormatter.string(from: date)
            return resultString
        }
        return ""
    }
    
    func timeAgo() -> String {
        let dateString = self
       // let dateFormatter = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" // ISO8601DateFormatter()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        if let date = dateFormatter.date(from: dateString) {
            
            let formatter = RelativeDateTimeFormatter()
            formatter.dateTimeStyle = .named
            formatter.unitsStyle = .full
            // formatter.locale = Locale.current
            
            let timeAgo = formatter.localizedString(for: date, relativeTo: Date())
            return timeAgo
        }
        return ""
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        guard let date = dateFormatter.date(from: self) else { return "" }
//
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
//         let localTime = dateFormatter.string(from: date)
//
//        if    let localDate = dateFormatter.date(from: localTime) {
//
//            let calendar = Calendar.current
//            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: localDate, to: Date())
//
//            let years = components.year!
//            let months = components.month!
//            let days = components.day!
//            let hours = components.hour!
//            let minutes = components.minute!
//            let seconds = components.second!
//
//            let l_years = "years".getLangText()
//            let l_months = "months".getLangText()
//            let l_days = "days".getLangText()
//            let l_hours = "hours".getLangText()
//            let l_minutes = "minutes".getLangText()
//            let l_seconds = "seconds".getLangText()
//            let l_ago = "ago".getLangText()
//
//
//            var timeAgo = ""
//            if years > 0 {
//                // print("\(years) years ago")
//                timeAgo = "\(years) \(l_years) \(l_ago)"
//            } else if months > 0 {
//                //print("\(months) months ago")
//                timeAgo = "\(months) \(l_months) \(l_ago)"
//
//            } else if days > 0 {
//                //print("\(days) days ago")
//                timeAgo = "\(days) \(l_days) \(l_ago)"
//
//            } else if hours > 0 {
//                //print("\(hours) hours ago")
//                timeAgo = "\(hours) \(l_hours) \(l_ago)"
//
//            } else if minutes > 0 {
//                //print("\(minutes) minutes ago")
//                timeAgo = "\(minutes) \(l_minutes) \(l_ago)"
//
//            } else {
//                //print("\(seconds) seconds ago")
//                timeAgo = "\(seconds) \(l_seconds) \(l_ago)"
//
//            }
//
//
//            return timeAgo
//        }
//        return ""
    }
    
    func toGetTimer() ->String? {
        let inputString = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        guard let date = dateFormatter.date(from: inputString) else {
            // handle error if the date string cannot be parsed
            return nil
        }

        dateFormatter.dateFormat = "HH:mm:ss"
        let outputString = dateFormatter.string(from: date)
        print(outputString)  // prints "21:17:32"
        return outputString
    }
    
    func formatNumbers() -> String {

//        let number = Double(self)
//        let thousand = (number ?? 0) / 1000
//        let million = (number ?? 0) / 1000000
//        if million >= 1.0 {
//            return "\(round(million*10)/10)M"
//        }
//        else if thousand >= 1.0 {
//            return "\(round(thousand*10)/10)K"
//        }
//        else {
//            return "\(self)"
//        }
        
        
                var roundedWithAbbreviations: String {
                 let number = Double(self) ?? 1
                 let thousand = number / 1000
                 let million = number / 1000000
                 if million >= 1.0 {
                     return "\(round(million*10)/10)M"
                 }
 //                else if thousand >= 1.0 {
 //                    return "\(round(thousand*10)/10)K"
 //                }
                 else {
                     return "\(self)"
                 }
             }
        
        return roundedWithAbbreviations
        
    }
    
//    var formatNumbers: String {
//            let number = Double(self)
//        let thousand = (number ?? 0) / 1000
//        let million = (number ?? 0) / 1000000
//            if million >= 1.0 {
//                return "\(round(million*10)/10)M"
//            }
//            else if thousand >= 1.0 {
//                return "\(round(thousand*10)/10)K"
//            }
//            else {
//                return "\(self)"
//            }
//        }
}
extension UIView {

    func takeScreenshot() -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}
extension Int {
    func formatNumbers() -> String {
        
            
   //     let longAmount = 4543335 //Int64(self)
        
      
       // let longAmount: Int64 = 1234567890

       
               var roundedWithAbbreviations: String {
                let number = Double(self)
                let thousand = number / 1000
                let million = number / 1000000
                if million >= 1.0 {
                    return "\(round(million*10)/10)M"
                }
//                else if thousand >= 1.0 {
//                    return "\(round(thousand*10)/10)K"
//                }
                else {
                    return "\(self)"
                }
            }


        return roundedWithAbbreviations
        
//            let thousand = 1000.0
//            let million = 1000000.0
//            let billion = 1000000000.0
//
//            if number >= billion {
//                let formatted = String(format: "%.2fB", number / billion)
//                return formatted
//            } else if number >= million {
//                let formatted = String(format: "%.2fM", number / million)
//                return formatted
//            } else if number >= thousand {
//                let formatted = String(format: "%.K", number / thousand)
//                return formatted
//            } else {
//                let formatted = String(format: "%", number)
//                return formatted
//            }
        

        
        
//        if number >= 10000, number <= 999999 {
//            return String(format: "%.1fK", locale: Locale.current,number/1000).replacingOccurrences(of: ".0", with: "")
//        }
//
//        if number > 999999 {
//            return String(format: "%.1fM", locale: Locale.current,number/1000000).replacingOccurrences(of: ".0", with: "")
//        }
//
//        return String(format: "%.0f", locale: Locale.current,number)
        

//        let number = Double(self)
//        let thousand = number / 1000
//        let million = number / 1000000
//        let billion = number / 1000000000
//
//        if billion >= 1.0 {
//            return "\(round(billion*10)/10)B"
//        } else if million >= 1.0 {
//            return "\(round(million*10)/10)M"
//        } else if thousand >= 1.0 {
//            return ("\(round(thousand*10/10))K")
//        } else {
//            return "\(Int(number))"
//        }
    }
}

extension Double {
    var kmFormatted: String {

        if self >= 10000, self <= 999999 {
            return String(format: "%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
        }

        if self > 999999 {
            return String(format: "%.1fM", locale: Locale.current,self/1000000).replacingOccurrences(of: ".0", with: "")
        }

        return String(format: "%.0f", locale: Locale.current,self)
    }
}

extension Date {

    func toString(_  format: String = "dd/MM/YYYY") -> String {
        
        let dateFormatter = DateFormatter()
     
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
    
    
}
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

extension Data {
    func parseDataToDic() -> Any? {
        let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers)
        return json
    }
}

extension UIImage {

    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }

}
extension UIView {

    var x: CGFloat {
        get {
            self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }

    var y: CGFloat {
        get {
            self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }

    var height: CGFloat {
        get {
            self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }

    var width: CGFloat {
        get {
            self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
}

struct Media {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String

    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpg"
        self.fileName = "\(arc4random()).jpeg"

        guard let data = image.jpegData(compressionQuality: 0.3) else { return nil }
        self.data = data
    }
}
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

extension UIImage {
    func parseQR() -> [String] {
        guard let image = CIImage(image: self) else {
            return []
        }

        let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                                  context: nil,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])

        let features = detector?.features(in: image) ?? []

        return features.compactMap { feature in
            return (feature as? CIQRCodeFeature)?.messageString
        }
    }
    func detectQRCode(_ image: UIImage?) -> [String]? {
        if let image = image, let ciImage = CIImage.init(image: image){
            var options: [String: Any]
            let context = CIContext()
            options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
            let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
            if ciImage.properties.keys.contains((kCGImagePropertyOrientation as String)){
                options = [CIDetectorImageOrientation: ciImage.properties[(kCGImagePropertyOrientation as String)] ?? 1]
            } else {
                options = [CIDetectorImageOrientation: 1]
            }
            let features = qrDetector?.features(in: ciImage, options: options)
          let code =  features?.compactMap { feature in
                return (feature as? CIQRCodeFeature)?.messageString
            }
            return code

        }
        return nil
    }
    
    func resizeImage( targetSize: CGSize) -> UIImage? {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


extension UIView {
    open func addRippleAnimation(color: UIColor, rippleWidth: CGFloat = 20, duration: Double = 1.5, repeatCount: Int = 1, rippleCount: Int = 3, rippleDistance: CGFloat? = nil, expandMaxRatio ratio: CGFloat = 5, startReset: Bool = true, handler:((CAAnimation)->Void)? = nil) {
        if startReset {
            removeRippleAnimation()
        } else {
            if isRippleAnimating {
                return
            }
        }
        let rippleAnimationAvatarSize = self.frame.size
        let rippleAnimationLineWidth: CGFloat = rippleWidth
        let rippleAnimationDuration: Double = duration
        var rippleAnimationExpandSizeValue: CGFloat = 0
        
        if let distance = rippleDistance {
            rippleAnimationExpandSizeValue = distance
        } else {
            rippleAnimationExpandSizeValue = rippleAnimationAvatarSize.width / 3.0
        }
        
        let initPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: rippleAnimationAvatarSize.width, height: rippleAnimationAvatarSize.height).insetBy(dx: rippleAnimationLineWidth, dy: rippleAnimationLineWidth))
        
        let finalPath = UIBezierPath(ovalIn: CGRect(x: -rippleAnimationExpandSizeValue * ratio, y: -rippleAnimationExpandSizeValue * ratio, width: rippleAnimationAvatarSize.width + rippleAnimationExpandSizeValue * 2 * ratio, height: rippleAnimationAvatarSize.height + rippleAnimationExpandSizeValue * 2 * ratio).insetBy(dx: rippleAnimationLineWidth, dy: rippleAnimationLineWidth))
        clipsToBounds = false
        
        
        
        let replicator = CAReplicatorLayer()
        replicator.instanceCount = rippleCount
        replicator.instanceDelay = rippleAnimationDuration / Double(rippleCount)
        replicator.backgroundColor = UIColor.clear.cgColor
        replicator.name = "ReplicatorForRipple"
        self.layer.addSublayer(replicator)

        let shape = animationLayer(path: initPath, color: color, lineWidth: rippleWidth)
        shape.name = "ShapeForRipple"
        shape.frame = CGRect(x: 0, y: 0, width: rippleAnimationAvatarSize.width, height: rippleAnimationAvatarSize.height)
        replicator.addSublayer(shape)

        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.isRemovedOnCompletion = true
        pathAnimation.fromValue = initPath.cgPath
        pathAnimation.toValue = finalPath.cgPath

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = NSNumber(value: 1)
        opacityAnimation.toValue = NSNumber(value: 0)

        let groupAnimation = CAAnimationGroup()
        handler?(groupAnimation)
        groupAnimation.animations = [pathAnimation, opacityAnimation]
        groupAnimation.duration = rippleAnimationDuration
        groupAnimation.repeatCount = Float(repeatCount)
        groupAnimation.isRemovedOnCompletion = true
        groupAnimation.fillMode = .forwards
        shape.add(groupAnimation, forKey: "RippleGroupAnimation")
        
    }
    
    open func removeRippleAnimation() {
        var layers: [CALayer] = []
        layer.sublayers?.forEach({ (layer) in
            if let replicator = layer as? CAReplicatorLayer, replicator.name == "ReplicatorForRipple" {
                replicator.sublayers?.forEach({ (ly) in
                    if ly.name == "ShapeForRipple" {
                        ly.isHidden = true
                        layers.append(ly)
                    }
                })
                replicator.isHidden = true
                layers.append(replicator)
            }
        })
        
        for i in 0..<layers.count {
            layers[i].removeFromSuperlayer()
        }
        layers.removeAll()
    }

    private func animationLayer(path: UIBezierPath, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = color.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = lineWidth
        shape.strokeColor = color.cgColor
        shape.lineCap = .round
        return shape
    }
    
    open var isRippleAnimating: Bool {
        var animating = false
        layer.sublayers?.forEach({ (layer) in
            if let replicator = layer as? CAReplicatorLayer, replicator.name == "ReplicatorForRipple" {
                animating = true
            }
        })
        return animating
    }
}

//class ShadowView: UIView {
//    /// The corner radius of the `ShadowView`, inspectable in Interface Builder
//    @IBInspectable var cornerRadius: CGFloat = 5.0 {
//        didSet {
//            self.updateProperties()
//        }
//    }
//    /// The shadow color of the `ShadowView`, inspectable in Interface Builder
//    @IBInspectable var shadowColor: UIColor = UIColor.black {
//        didSet {
//            self.updateProperties()
//        }
//    }
//    /// The shadow offset of the `ShadowView`, inspectable in Interface Builder
//    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 2) {
//        didSet {
//            self.updateProperties()
//        }
//    }
//    /// The shadow radius of the `ShadowView`, inspectable in Interface Builder
//    @IBInspectable var shadowRadius: CGFloat = 4.0 {
//        didSet {
//            self.updateProperties()
//        }
//    }
//    /// The shadow opacity of the `ShadowView`, inspectable in Interface Builder
//    @IBInspectable var shadowOpacity: Float = 0.5 {
//        didSet {
//            self.updateProperties()
//        }
//    }
//
//    /**
//    Masks the layer to it's bounds and updates the layer properties and shadow path.
//    */
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        self.layer.masksToBounds = false
//
//        self.updateProperties()
//        self.updateShadowPath()
//    }
//
//    /**
//    Updates all layer properties according to the public properties of the `ShadowView`.
//    */
//    fileprivate func updateProperties() {
//        self.layer.cornerRadius = self.cornerRadius
//        self.layer.shadowColor = self.shadowColor.cgColor
//        self.layer.shadowOffset = self.shadowOffset
//        self.layer.shadowRadius = self.shadowRadius
//        self.layer.shadowOpacity = self.shadowOpacity
//    }
//
//    /**
//    Updates the bezier path of the shadow to be the same as the layer's bounds, taking the layer's corner radius into account.
//    */
//    fileprivate func updateShadowPath() {
//        self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
//    }
//
//    /**
//    Updates the shadow path everytime the views frame changes.
//    */
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        self.updateShadowPath()
//    }
//}


//class DottedLineView: UIView {
//    override class var layerClass: AnyClass {
//        return CAShapeLayer.self
//    }
//    
//    private var dashedLineLayer: CAShapeLayer? {
//        return layer as? CAShapeLayer
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        updateDottedLine()
//    }
//    
//    private func updateDottedLine() {
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
//        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
//        
//        dashedLineLayer?.strokeColor = UIColor.black.cgColor // Set the line color
//        dashedLineLayer?.lineWidth = 2.0 // Set the line width
//        dashedLineLayer?.lineJoin = .round
//        dashedLineLayer?.lineDashPattern = [4, 4] // Set the dash pattern
//        
//        dashedLineLayer?.path = path.cgPath
//    }
//}


import UIKit

//class DividedSeekBar: UIView {
//    private var newLevel = 4
//    var onLevelChanged: ((Int) -> Void)?
//
//    private let green = UIColor.systemGreen
//    private var bars: [UIView] = []
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupView()
//    }
//
//    private func setupView() {
//        let containerStackView = UIStackView()
//        containerStackView.translatesAutoresizingMaskIntoConstraints = false
//        containerStackView.axis = .horizontal
//        containerStackView.distribution = .fillEqually
//        containerStackView.spacing = 8 // Adjust the spacing as needed
//
//        for i in 1...4 {
//            let bar = UIView()
//            bar.translatesAutoresizingMaskIntoConstraints = false
//            bar.backgroundColor = .white
//            containerStackView.addArrangedSubview(bar)
//            bars.append(bar)
//
//            if i < 4 {
//                let divider = UIView()
//                divider.translatesAutoresizingMaskIntoConstraints = false
//                divider.backgroundColor = .white
//                divider.widthAnchor.constraint(equalToConstant: 8).isActive = true // Adjust the divider width as needed
//                containerStackView.addArrangedSubview(divider)
//            }
//        }
//
//        addSubview(containerStackView)
//        NSLayoutConstraint.activate([
//            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
//            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
//            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
//            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
//        ])
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        containerStackView.addGestureRecognizer(tapGesture)
//
//        setLevel(newLevel)
//    }
//
//    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
//        let location = gesture.location(in: self)
//        let level = Int((location.x / bounds.width) * 4) + 1
//        setLevel(level)
//    }
//
//    private func createRoundedLayer(leftRounded: Bool, rightRounded: Bool) -> CALayer {
//        let layer = CALayer()
//        layer.backgroundColor = green.cgColor
//        let radius: CGFloat = 26
//        layer.cornerRadius = radius
//        layer.maskedCorners = [
//            leftRounded ? .layerMinXMinYCorner : .layerMinXMinYCorner,
//            rightRounded ? .layerMaxXMinYCorner : .layerMaxXMinYCorner,
//            rightRounded ? .layerMaxXMaxYCorner : .layerMaxXMaxYCorner,
//            leftRounded ? .layerMinXMaxYCorner : .layerMinXMaxYCorner
//        ]
//        return layer
//    }
//
//    func setLevel(_ level: Int) {
//        newLevel = max(1, min(4, level))
//
//        for (index, bar) in bars.enumerated() {
//            switch index {
//            case 0: // First bar
//                bar.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
//                let leftRounded = newLevel >= 1
//                let rightRounded = newLevel > 1
//                let layer = createRoundedLayer(leftRounded: leftRounded, rightRounded: rightRounded)
//                bar.layer.addSublayer(layer)
//                layer.frame = bar.bounds
//            case 6: // Last bar
//                bar.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
//                let leftRounded = newLevel >= 4
//                let rightRounded = newLevel == 4
//                let layer = createRoundedLayer(leftRounded: leftRounded, rightRounded: rightRounded)
//                bar.layer.addSublayer(layer)
//                layer.frame = bar.bounds
//            default: // Middle bars
//                bar.backgroundColor = index < newLevel ? green : .white
//                bar.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
//            }
//        }
//
//        onLevelChanged?(newLevel)
//    }
//}
import Foundation

extension UnicodeScalar {
    var isEmoji: Bool {
        switch value {
        case 0x1F600...0x1F64F, // Emoticons
             0x1F300...0x1F5FF, // Misc Symbols and Pictographs
             0x1F680...0x1F6FF, // Transport and Map
             0x1F1E6...0x1F1FF, // Regional country flags
             0x2600...0x26FF, // Misc symbols
             0x2700...0x27BF, // Dingbats
             0xE0020...0xE007F, // Tags
             0xFE00...0xFE0F, // Variation Selectors
             0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
             0x1F018...0x1F270, // Various asian characters
             0x238C...0x2454, // Misc items
             0x20D0...0x20FF: // Combining Diacritical Marks for Symbols
            return true

        default: return false
        }
    }

    var isZeroWidthJoiner: Bool {
        return value == 8205
    }
}

extension String {
    // Not needed anymore in swift 4.2 and later, using `.count` will give you the correct result
    var glyphCount: Int {
        let richText = NSAttributedString(string: self)
        let line = CTLineCreateWithAttributedString(richText)
        return CTLineGetGlyphCount(line)
    }

    var isSingleEmoji: Bool {
        return glyphCount == 1 && containsEmoji
    }

    var containsEmoji: Bool {
        return unicodeScalars.contains { $0.isEmoji }
    }

    var containsOnlyEmoji: Bool {
        return !isEmpty
            && !unicodeScalars.contains(where: {
                !$0.isEmoji && !$0.isZeroWidthJoiner
            })
    }

    // The next tricks are mostly to demonstrate how tricky it can be to determine emoji's
    // If anyone has suggestions how to improve this, please let me know
    var emojiString: String {
        return emojiScalars.map { String($0) }.reduce("", +)
    }

    var emojis: [String] {
        var scalars: [[UnicodeScalar]] = []
        var currentScalarSet: [UnicodeScalar] = []
        var previousScalar: UnicodeScalar?

        for scalar in emojiScalars {
            if let prev = previousScalar, !prev.isZeroWidthJoiner, !scalar.isZeroWidthJoiner {
                scalars.append(currentScalarSet)
                currentScalarSet = []
            }
            currentScalarSet.append(scalar)

            previousScalar = scalar
        }

        scalars.append(currentScalarSet)

        return scalars.map { $0.map { String($0) }.reduce("", +) }
    }

    fileprivate var emojiScalars: [UnicodeScalar] {
        var chars: [UnicodeScalar] = []
        var previous: UnicodeScalar?
        for cur in unicodeScalars {
            if let previous = previous, previous.isZeroWidthJoiner, cur.isEmoji {
                chars.append(previous)
                chars.append(cur)

            } else if cur.isEmoji {
                chars.append(cur)
            }

            previous = cur
        }

        return chars
    }
    var textWithoutEmojis: String {
            let emojiSet = Set(emojis)
            return unicodeScalars.filter { !emojiSet.contains(String($0)) }.map { String($0) }.joined()
        }
    
    func calculateRemainingTime() -> String {
        // Get the current date and time
        let currentDate = Date()

           // Get the Calendar instance
           let calendar = Calendar.current

           // Calculate the end of the current day (midnight)
           let endOfDay = calendar.startOfDay(for: currentDate).addingTimeInterval(86400) // 86400 seconds = 1 day

           // Calculate the time difference
        let timeDifference = calendar.dateComponents([.hour, .minute, .second], from: currentDate, to: endOfDay)

           // Extract hours and minutes from the time difference
           let hours = timeDifference.hour ?? 0
           let minutes = timeDifference.minute ?? 0
           let sec = timeDifference.second ?? 0
        
           // Format the remaining time as "Xh:Ym"
           let formattedTime = "Limit resets in: \(hours)h :\(minutes)m :\(sec)s"

           return formattedTime
       }

 



}
extension Locale {
    func isoCode(for countryName: String) -> String? {
        return Locale.isoRegionCodes.first(where: { (code) -> Bool in
            localizedString(forRegionCode: code)?.compare(countryName, options: [.caseInsensitive, .diacriticInsensitive]) == .orderedSame
        })
    }
}
public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                       return "iPod touch (5th generation)"
            case "iPod7,1":                                       return "iPod touch (6th generation)"
            case "iPod9,1":                                       return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":           return "iPhone 4"
            case "iPhone4,1":                                     return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                        return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                        return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                        return "iPhone 5s"
            case "iPhone7,2":                                     return "iPhone 6"
            case "iPhone7,1":                                     return "iPhone 6 Plus"
            case "iPhone8,1":                                     return "iPhone 6s"
            case "iPhone8,2":                                     return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                        return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                        return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                      return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                      return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                      return "iPhone X"
            case "iPhone11,2":                                    return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                      return "iPhone XS Max"
            case "iPhone11,8":                                    return "iPhone XR"
            case "iPhone12,1":                                    return "iPhone 11"
            case "iPhone12,3":                                    return "iPhone 11 Pro"
            case "iPhone12,5":                                    return "iPhone 11 Pro Max"
            case "iPhone13,1":                                    return "iPhone 12 mini"
            case "iPhone13,2":                                    return "iPhone 12"
            case "iPhone13,3":                                    return "iPhone 12 Pro"
            case "iPhone13,4":                                    return "iPhone 12 Pro Max"
            case "iPhone14,4":                                    return "iPhone 13 mini"
            case "iPhone14,5":                                    return "iPhone 13"
            case "iPhone14,2":                                    return "iPhone 13 Pro"
            case "iPhone14,3":                                    return "iPhone 13 Pro Max"
            case "iPhone14,7":                                    return "iPhone 14"
            case "iPhone14,8":                                    return "iPhone 14 Plus"
            case "iPhone15,2":                                    return "iPhone 14 Pro"
            case "iPhone15,3":                                    return "iPhone 14 Pro Max"
            case "iPhone8,4":                                     return "iPhone SE"
            case "iPhone12,8":                                    return "iPhone SE (2nd generation)"
            case "iPhone14,6":                                    return "iPhone SE (3rd generation)"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":      return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":                 return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":                 return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                          return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                            return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                          return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7":                          return "iPad (8th generation)"
            case "iPad12,1", "iPad12,2":                          return "iPad (9th generation)"
            case "iPad13,18", "iPad13,19":                        return "iPad (10th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":                 return "iPad Air"
            case "iPad5,3", "iPad5,4":                            return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                          return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2":                          return "iPad Air (4th generation)"
            case "iPad13,16", "iPad13,17":                        return "iPad Air (5th generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":                 return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":                 return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":                 return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                            return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                          return "iPad mini (5th generation)"
            case "iPad14,1", "iPad14,2":                          return "iPad mini (6th generation)"
            case "iPad6,3", "iPad6,4":                            return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                            return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":      return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                           return "iPad Pro (11-inch) (2nd generation)"
            case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":  return "iPad Pro (11-inch) (3rd generation)"
            case "iPad14,3", "iPad14,4":                          return "iPad Pro (11-inch) (4th generation)"
            case "iPad6,7", "iPad6,8":                            return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                            return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":      return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                          return "iPad Pro (12.9-inch) (4th generation)"
            case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":return "iPad Pro (12.9-inch) (5th generation)"
            case "iPad14,5", "iPad14,6":                          return "iPad Pro (12.9-inch) (6th generation)"
            case "AppleTV5,3":                                    return "Apple TV"
            case "AppleTV6,2":                                    return "Apple TV 4K"
            case "AudioAccessory1,1":                             return "HomePod"
            case "AudioAccessory5,1":                             return "HomePod mini"
            case "i386", "x86_64", "arm64":                       return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                              return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}
extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}
extension String {
    func extractCountryCode() -> String {
        let pattern = try! NSRegularExpression(pattern: "([a-zA-Z]+-[a-zA-Z]+)-.*")
        if let match = pattern.firstMatch(in: self, range: NSRange(self.startIndex..., in: self)) {
            let range = Range(match.range(at: 1), in: self)!
            return String(self[range])
        }
        return "en-US"
    }
}
