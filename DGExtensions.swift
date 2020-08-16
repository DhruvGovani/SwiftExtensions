//
//  DGExtensions.swift
//  
//
//  Created by Dhruv Govani on 27/06/20.
//
//  GIT : https://github.com/DhruvGovani/SwiftExtensions
//  Readme: https://github.com/DhruvGovani/SwiftExtensions/blob/master/README.md
/**

 Copyright (c) 2020 Dhruv Govani

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 */

import Foundation
import UIKit
import WebKit

enum Location {
    case left, right
}

enum ShowStyle {
    case Push, Present
}

enum DateTimeZone {
    case Local, UTC
}

enum GradientDirection{
    case Horizontal
    case Vertical
}

extension UIView{
    ///Round the edges of all views defined in parameter
    ///Usage : UIView().RoundEdgesOf(Views: [Label,TextField,Button,SubView])
    func RoundEdgesOf(Views : [UIView]){
        
        for i in Views{
            i.clipsToBounds = true
            i.layer.cornerRadius = i.frame.height / 2
        }
        
    }
    ///Round the edges of all view
    func RoundMe(Radius : CGFloat?){
        self.clipsToBounds = true
        self.layer.cornerRadius = Radius ?? self.frame.height / 2
    }
    /// This function will add an additional border near the View's frame
    /// - mostly useful when you wanted to show the border around view with little bit space
    /// - note: Formula For Rounded Border : YourMainView.frame.height + width + spacing / 2
    /// - parameter width : width of the border
    /// - parameter Spacing : spacing between border and your view
    /// - parameter CornderRadius : Corner radius for Border
    /// - parameter BorderColor : Color of border
    func DGBorderView(width : CGFloat, Spacing : CGFloat, CornderRadius : CGFloat?, BorderColor : UIColor?){
                
        let DGBorderView = UIView(frame: .zero)
        
        DGBorderView.translatesAutoresizingMaskIntoConstraints = false
        
        DGBorderView.clipsToBounds = true
        
        if let ParentView = self.superview{
            
            if let index =  ParentView.subviews.firstIndex(of: self){
                ParentView.insertSubview(DGBorderView, at: index)
            }else{
                ParentView.addSubview(DGBorderView)
                ParentView.sendSubviewToBack(DGBorderView)
            }
            
            NSLayoutConstraint.activate([
                DGBorderView.topAnchor.constraint(equalTo: self.topAnchor, constant: -(Spacing)),
                DGBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -(Spacing)),
                DGBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: (Spacing)),
                DGBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: (Spacing))
            ])
            
            if let color = BorderColor{
                DGBorderView.layer.borderColor = color.cgColor
            }
            
            if let radius = CornderRadius{
                DGBorderView.layer.cornerRadius = radius
            }
            
            DGBorderView.layer.borderWidth = width
        }
                
    }
    
    /// It will return the Current X and  Y of  the UIView
    var globalPoint :CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }
    
    /// It will return the Current X , Y, H, and W of the UIView
    var globalFrame :CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
    
    ///This function will give the border to the view.
    /// - parameter Color: Color of the border
    /// - parameter BorderWidth: Width of the border you want
    func BorderMe(Color : UIColor, BorderWidth : CGFloat){
        self.layer.borderColor = Color.cgColor
        self.layer.borderWidth = BorderWidth
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
    
    ///This Function will drop a shadow for the view based on the provided input
    /// - parameter ShadowColor : Color of shadow
    /// - parameter radius : radius of shadow
    /// - parameter Height : Vertical weight
    /// - parameter Width: Horizontal weight
    /// - parameter Opacity : Opciity of shadow
    /// - parameter CornerRadius : radius of corners of shadow
    func dropShadow(ShadowColor : UIColor, radius : CGFloat, Height : CGFloat, Width: CGFloat, Opacity : Float, CornerRadius : CGFloat){
        
        if CornerRadius > 0{
            self.layer.cornerRadius = CornerRadius
        }
        
        self.layer.shadowColor = ShadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: Width, height: Height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = Opacity
        self.layer.masksToBounds = false;
        
    }
    
    ///This Function vill add gradient layer at ) index of the UIView
    /// - colors will be in sequence provided index vise
    /// - parameter Direction : Direction will define the direction of gradient flow
    /// - parameter Colors : Array of CGColors You wanted to make garient of
    func GradientView(Direction : GradientDirection, Colors : [CGColor]){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Colors
        
        if Direction == .Horizontal{
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        }else{
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        }
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension String{
    ///This will return the substring after the occurance of specfied character
    /// - parameter after : specify the Character which will provide the substring after its occurance
    /// - this will return substring of type String
    /// - returns: Substring after the occuarance of current string
    func getSubstring(after : String) -> String{
        
        if let range = self.range(of: after) {
            let substring = self[range.upperBound...]
            return String(substring)
        }else{
            return self
        }
        
    }
    
    /// you can use this function to check the email is valid or invalid
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    /// returns the boolean value telling if string contains the whitespace or not
    var containsWhitespace: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x20:
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// This function will remove all the white space and new lines  from trailing or leading of the text inside of the textview
    /// - user it inside end editing of text field or textview for best result
    mutating func removeWhiteSpacesNearMe(){
           let trimmedText = self.trimmingCharacters(in: .whitespacesAndNewlines)
           self = trimmedText
    }
    
    /// This function will convert the string date to a perticular format.
    /// - must provide a valid string or you will get some default date
    /// Formats :  Here is all formats for ease of use
    /// - parameter currentFormat: Current format of the date
    /// - parameter toFormat: output format of the date
    /// - returns: String output of the date in specfied format
    /// - yy :   08
    /// - yyyy :   2008
    /// - M  -  12
    /// - MM  - 12
    /// - MMM - Dec
    /// - MMMM  - December
    /// - MMMMM  - D
    /// - d - 14
    /// - dd - 14
    /// - F - 3rd Tuesday in December
    /// - E - Tues
    /// - EEEE - Tuesday
    /// - EEEEE - T
    /// - h  -  4
    /// - hh -   04
    /// - H   - 16
    /// - HH  - 16
    /// - a  -  PM
    /// - zzz  -  CST  :  The 3 letter name of the time zone. Falls back to GMT-08:00 (hour offset) if the name is not known.
    /// - zzzz -  Central Standard Time  : The expanded time zone name, falls back to GMT-08:00 (hour offset) if name is not known.
    /// - zzzz  -  CST-06:00  : Time zone with abbreviation and offset
    /// - Z  -  -0600  :  RFC 822 GMT format. Can also match a literal Z for Zulu (UTC) time.
    /// - ZZZZZ  - -06:00
    func convertDate_ToFormat(currentFormat: String, toFormat : String) ->  String {
        
        let dateFormator = DateFormatter()
        dateFormator.locale = Locale(identifier: "en_US_POSIX")
        dateFormator.dateFormat = currentFormat
        let resultDate = dateFormator.date(from: self) ?? Date(timeInterval: -3600, since: Date())
        dateFormator.dateFormat = toFormat
        return dateFormator.string(from: resultDate)
    }
    
    /// This function will convert the date string into Date Object
    /// - parameter format : format for the date object you want in
    /// - parameter timeZone: timezone for the date
    /// - returns: Date object based on the string and timezone provided
    func toDate(format : String, timeZone : DateTimeZone?) -> Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = format
        switch timeZone {
        case .Local:
            dateFormatter.timeZone = TimeZone.current
        case .UTC:
            dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        case .none:
            break
        }
        
        let date = dateFormatter.date(from:self) ?? Date()
        return date
    }
    
    /// This function will give you a string which will describe the time difference in human readable form from the today's date
    /// - this functionnis best for post's and commenys
    /// - the output will be both in singular and plural
    /// - parameter currentFormat : Current format of your date
    /// - parameter timeZone: timezone you wanted to be done conversion in
    /// - returns: returns a string with proper time difference explanation
    func getElapsedInterval(currentFormat : String, timeZone : DateTimeZone) -> String {
        
        let fromDate = self.toDate(format: currentFormat, timeZone: timeZone)
        
        let toDate = Date()
        
        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }
        
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }
        
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }
        
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }
        
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }
        
        return "a moment ago"
        
    }
    
    enum TimeConversionMode{
        case From24To12, From12To24
    }
    
    /// This Fucntion will convert the time based on your choices
    /// - incoming/Outgoing format : 12Hours : "12:00 AM" , 24Hours : "13:00:00"
    /// - parameter mode: mode of the conversion
    /// - returns: Will returns the string after conversion
    func timeConversion(mode : TimeConversionMode) -> String {
        let dateAsString = self
        let df = DateFormatter()
        df.locale =  Locale(identifier: "en_US_POSIX")
        switch mode {
        case .From24To12:
            df.dateFormat = "HH:mm:ss"
        case .From12To24:
            df.dateFormat = "hh:mm a"
        }

        let date = df.date(from: dateAsString)
        
        switch mode {
        case .From24To12:
            df.dateFormat = "hh:mm a"
        case .From12To24:
            df.dateFormat = "HH:mm:ss"
        }
        
        let convertedTime = df.string(from: date ?? Date(timeInterval: -3600, since: Date()))
        
        return convertedTime
    }
    
    /// This Fucntion will convert the date time based on your choices
    /// - Note: date will be formated as it is and time will be as below
    /// - format:  12Hours : "12:00 AM" , 24Hours : "13:00:00"
    /// - parameter mode: mode of the conversion
    /// - returns: Will returns the string after conversion
    func DateAndtimeConversion(OnlyDateFormat: String, mode : TimeConversionMode) -> String {
        let dateAsString = self
        let df = DateFormatter()
        df.locale =  Locale(identifier: "en_US_POSIX")
        
        switch mode {
        case .From24To12:
            df.dateFormat = "\(OnlyDateFormat) HH:mm:ss"
        case .From12To24:
            df.dateFormat = "\(OnlyDateFormat) HH:mm a"
        }

        let date = df.date(from: dateAsString)
        
        switch mode {
        case .From24To12:
            df.dateFormat = "\(OnlyDateFormat) HH:mm a"
        case .From12To24:
            df.dateFormat = "\(OnlyDateFormat) HH:mm:ss"
        }

        let newDate = df.string(from: date ?? Date(timeInterval: -3600, since: Date()))
        
        return newDate
    }
    
    enum TimeDifference {
        case year,month,hour,Minute,Second
    }
    
    /// This function will add the time sepcified difference in given time Date/Time
    /// - this fucntion will calculate the difference based on the all the logical calanderic calculations
    /// - note: If you are getting today's date; bro, something's wrong.
    /// - parameter Step: number of amount of time you want to add
    /// - parameter DifferenceIn: time difference unit
    /// - parameter InputFormat: format of your current date
    /// - parameter OutputFormat: format of output
    /// - returns: Will return string with added time difference
    func AddtimeDifference(Step : Int, DifferenceIn: TimeDifference, InputFormat: String, OutputFormat : String) -> String{
        
        
           let dateFormatter = DateFormatter()
        dateFormatter.locale =  Locale(identifier: "en_US_POSIX")

           dateFormatter.dateFormat = InputFormat

        let time = dateFormatter.date(from: self)
        
        var timeInterval = TimeInterval(60)
        
        switch DifferenceIn {
        case .year:
            timeInterval = TimeInterval(31536000 * Step)
        case .month:
            timeInterval = TimeInterval(2628000 * Step)
        case .hour:
            timeInterval = TimeInterval(86399 * Step)
        case .Minute:
            timeInterval = TimeInterval(60 * Step)
        case .Second:
            timeInterval = TimeInterval(1 * Step)
        }
        
        let addedInterval = time?.addingTimeInterval(timeInterval) ?? Date(timeInterval: -3600, since: Date())
        
           dateFormatter.dateFormat = OutputFormat
        let after_add_time = dateFormatter.string(from: addedInterval)
        
        return after_add_time
    }
    
    ///This Function will capitalize the First letter of the string
    /// - returns: string with first capitalize letter
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizeFirstLetter()
    }
    
    /// This function will return the approx height needed by the string to fit in an UILable based on a fixed width
    /// - make sure you provide the perfect font size or greater than the current point for more good output
    /// - parameter width: fix width of the string
    /// - parameter font: font size of the lable
    /// - returns: Will return approx height for the lable
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
    ///This function will remove extra new lines from your string
    mutating func removeExtraNewLines() -> String{
        _ = self.trimmingCharacters(in: CharacterSet.newlines)
        // replace occurences within the string
        while let rangeToReplace = self.range(of: "\n\n\n") {
            self.replaceSubrange(rangeToReplace, with: "\n")
        }
        
        return self
    }
    
    /// This function will find the text starts with the char specified and will returns the array of that strings
    /// - parameter Character: a single char to find string with
    /// - parameter removeCharFromResult: if you wanted to remove special char from the resulting array
    /// - returns: Array of String with all matching strings
    func findTextStartsWith(Character : String, removeCharFromResult : Bool) -> [String] {
        var arr_hasStrings:[String] = []
        let Char = Character.first
        let regex = try? NSRegularExpression(pattern: "(\(Char ?? "#")[a-zA-Z0-9_\\p{Arabic}\\p{N}]*)", options: [])
        if let matches = regex?.matches(in: self, options:[], range:NSMakeRange(0, self.count)) {
            for match in matches {
                arr_hasStrings.append(NSString(string: self).substring(with: NSRange(location:match.range.location, length: match.range.length )))
            }
        }
        
        if removeCharFromResult{
            for i in 0..<arr_hasStrings.count{
                arr_hasStrings[i].removeFirst()
            }
        }
        
        return arr_hasStrings
    }
    
    /// This funtion will encode the text for emoji support to sent to server
    func encode() -> String {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    /// This funtion will decode the text for emoji support to display
    func decode() -> String {
        if let data = self.data(using: .utf8){
            return String(data: data, encoding: .nonLossyASCII) ?? ""
        }else{
            return ""
        }
    }
    
    /// This Function will attribute the color of hashtags in your string and will return NSAttributedString
    /// - supports emoji
    /// - user encode() for converting emojis
    /// - will change the color and also can give line space if not null
    /// - parameter FontColor: Color of the hashtags you want
    /// - parameter lineSpacing: Linespacing you want between lines of text
    func AttributedHashtags(FontColor : UIColor,lineSpacing : CGFloat?) -> NSAttributedString {
        let attrStr = NSMutableAttributedString(string: self.decode())
       let searchPattern = "#\\w+"
       var ranges: [NSRange] = [NSRange]()

       let regex = try! NSRegularExpression(pattern: searchPattern, options: [])
        ranges = regex.matches(in: attrStr.string, options: [], range: NSMakeRange(0, attrStr.string.utf16.count)).map {$0.range}

       for range in ranges {
        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: FontColor, range: NSRange(location: range.location, length: range.length))
       }
        
        if let LSpacing = lineSpacing{
            let paragraphStyle = NSMutableParagraphStyle()
            
            paragraphStyle.lineSpacing = LSpacing
            
            attrStr.addAttribute(
                .paragraphStyle,
                value: paragraphStyle,
                range: NSRange(location: 0, length: attrStr.length
            ))
        }
        return attrStr
    }
    
    /// This function will convert the String into Dictionary
    /// - returns: will return a Disctionary if conversion is successful
    func stringTodictionary() -> [String:Any]? {

      var dictonary:[String:Any]?

      if let data = self.data(using: .utf8) {

        do {
          dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]

          if let myDictionary = dictonary
          {
            return myDictionary;
          }
        } catch let error as NSError {
          print(error)
        }

      }
      return dictonary;
    }
    
    /// This Function will return the Size of string based on the fonts
    /// - returns: CGSize For the String
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    /// Will return the substring from the defined index
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, self.count) ..< self.count]
    }
    
    /// Will return the substring from 0 to Defined index
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(self.count, r.lowerBound)),
                                            upper: min(self.count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    /// This function will fill your string whenever X is occur
    /// - parameter mask: format of the number ex, : +XX-XXXXX-XXXXX
    /// - make sure your mask length is > then your string to full fill it
    /// - returns: String by replacing all X with the strings
    /// - Usage: "1234567890".toPhoneNumber(mask: "+XX-XXXXX-XXXXX")
    func toPhoneNumber(mask: String) -> String{
        
        let numbers = self
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    /// This function will return a countdown string which will indicate the remaining time to the date from current time and date
    /// - parameter dateFormat: format of your date
    /// - returns: String e.i. : 5 Days 19 Hours
    func RemainingTimeTo(dateFormat : String) -> String{
        
       let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = dateFormat
        let releaseDate = releaseDateFormatter.date(from:self) ?? Date()

        let date = releaseDateFormatter.date(from: "") ?? Date()
        
        let calendar = Calendar.current

        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: date, to: releaseDate)
        
        let days = diffDateComponents.day ?? 0
        let hours = diffDateComponents.hour ?? 0
        let mins = diffDateComponents.minute ?? 0
        if days > 0{
            
            if hours > 0{
                return "\(String(days)) days \(String(hours)) hours"
            }else{
                return "\(String(days)) days"
            }
            
        }else{
            
            if hours > 0{
                return "\(String(hours)) hours"
            }else{
                return "\(String(mins)) Minutes"
            }
            
        }
        
    }
    
    /// this function will format your string into a currency format
    /// - parameter fraction: fraction the string after length. default is 2
    /// - returns: Currency formatted string, e.i: 10000 -> 100,000
    func currencyFormatting(fraction : Int?) -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = fraction ?? 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
}

extension UIButton{
    ///This will return the Colorize the button title specfied range
    /// - parameter text : title of your button
    /// - parameter from: Starting position
    /// - parameter length: end position
    /// - parameter color: uicolor for specified title
    /// - this will return substring of type String
    func AttributeMyTitle(_ text:String, from: Int, length: Int, color : UIColor){
        let att = NSMutableAttributedString(string: text);
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: from, length: length))
        self.setAttributedTitle(att, for: .normal)
    }
    
    ///This Function will underline the current text of the button for specified range
    /// - if range is nil then whole text will be underlined
    /// - Color will be as tint color
    /// - parameter Range : Range of text you want underline only
    func UnderLineButton(Range : NSRange?){
        
        let Text = self.titleLabel?.text ?? ""
        
        let attributedText = NSMutableAttributedString(string: Text)
        
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: Range ??  NSRange(location: 0, length: Text.count))
        
        
        attributedText.addAttributes([NSAttributedString.Key.foregroundColor : self.tintColor ?? UIColor.black], range: Range ??  NSRange(location: 0, length: Text.count))
        
        self.setAttributedTitle(attributedText, for: .normal)
    }
}

extension UILabel{
    ///This function will add inter line spacing to your lable with the help of NSMutableAttributedString
    /// - note: Make sure numberOfLines is set to 0 or > 1 for line spacing.
    /// - String must be > 0 to get this running
    /// - parameter spacingValue: Space between lines you wanted if not nil
    /// - parameter CharacterSpacing:  will add space between characters if not nil
    func addSpacing(spacingValue: CGFloat?, CharacterSpacing : Double?, range : NSRange?) {

        guard let textString = text else { return }
        
        guard (textString.count > 0) else { return }

        let attributedString = NSMutableAttributedString(string: textString)

        let paragraphStyle = NSMutableParagraphStyle()
        
        if let LSpace = spacingValue{
            paragraphStyle.lineSpacing = LSpace
            
            attributedString.addAttribute(
                .paragraphStyle,
                value: paragraphStyle,
                range: range ?? NSRange(location: 0, length: attributedString.length
            ))
        }
        
        if let CSpace = CharacterSpacing{
            attributedString.addAttribute(NSAttributedString.Key.kern, value: CSpace, range: range ?? NSRange(location: 0, length: attributedString.length - 1))
        }

        attributedText = attributedString
    }
    
    /// This function will underline your lable text
    /// - parameter Color : Color of the text default is textColor or Black
    /// - parameter range :  The range of text you wanted with underline default is all
    func GiveMeUnderline(Color : UIColor?, range : NSRange?){
        
        if let text = self.text{
            
            let attributedText = NSMutableAttributedString(string: text)
            
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: range ?? NSRange(location: 0, length: text.count))
            
            
            attributedText.addAttributes([NSAttributedString.Key.foregroundColor : Color ?? self.textColor ?? UIColor.black], range: range ?? NSRange(location: 0, length: text.count))
            
            self.attributedText = attributedText
        }
    }
}

extension UIImage{
    
    enum ContentMode {
        case contentFill
        case contentAspectFill
        case contentAspectFit
    }
    
    /// This Function will returns the resized image with prescribed contentMode
    /// - parameter withSize: Size of image
    /// - parameter contentMode: Mode of image inside frame
    func resize(withSize size: CGSize, contentMode: ContentMode = .contentAspectFill) -> UIImage? {
        let aspectWidth = size.width / self.size.width
        let aspectHeight = size.height / self.size.height

        switch contentMode {
        case .contentFill:
            return resize(withSize: size)
        case .contentAspectFit:
            let aspectRatio = min(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        case .contentAspectFill:
            let aspectRatio = max(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        }
    }
    private func resize(withSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// This function will create a selection indicator for UITabbarConrollers
    /// - parameter color: Color of indicator
    /// - parameter size: size of indicator
    /// - parameter lineWidth: width of indicator
    /// - returns: UIImage with sepcified attributes
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: size.height - lineWidth, width: size.width, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? #imageLiteral(resourceName: "RecMessage.png")
        UIGraphicsEndImageContext()
        return image
    }
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// - If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - parameter jpegQuality : quality you wanted of the image data to be
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
    
    /// Compresses the UIImage to the certain quality
    /// - this function will compromise the qulity and size of image
    /// - parameter CompressionMode : thq quality compressions mode you want for the image
    /// - returns: Compressed images based on specfied mode
    func Compress(CompressionMode : JPEGQuality) -> UIImage{
        let CompressedImage = self.jpegData(compressionQuality: CompressionMode.rawValue)!
        
        return UIImage(data: CompressedImage)!
    }
    
    /// This function will initalize the new uiimage with the sepcified size and color
    /// - parameter color: Color of the UIImage You wanted
    /// - parameter size: Size of the image you wanted
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
      let rect = CGRect(origin: .zero, size: size)
      UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
      color.setFill()
      UIRectFill(rect)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      guard let cgImage = image?.cgImage else { return nil }
      self.init(cgImage: cgImage)
    }
    
    /// this function will convert the gradient layer into UIImage
    /// - image size will be the same as gradient layer size
    /// - parameter gradientLayer: CAGradientLayer you wanted to convert to
    /// - returns: UIImage from the gradientLayer
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
    /// This function will create the image from layer of the layer Size
    /// - parameter layer: CALayer you wanted to turn into an Image
    /// - returns: Optional UIImage
    static func imageFromLayer (layer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContext(layer.frame.size)
        guard let currentContext = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in: currentContext)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage
    }
    
}

extension UITextField{
    /// This function will append the text for UITextField
    /// - parameter Spacing: Size spacing you want
    func appendText(Spacing : CGFloat, Direction : Location) {
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: Spacing, height: self.frame.height))
        if Direction == .left{
            leftView = iconContainerView
            leftViewMode = .always
        }else{
            rightView = iconContainerView
            rightViewMode = .always
        }
    }
    
    /// This function will set an icon to the specfied position for both boxed and round edges TextField
    /// -  if isRounded is true the the textfield will be autometically gets rounded
    /// - you can always override the corner radius property
    /// - make sure your icon or image is propery with edge insets
    /// - parameter Postion : Position of the icon in textfield
    /// - parameter Image : Icon asset you want to set
    /// - parameter isRounded : if textfield is rounded or not
    func setIcon(Postion : Location, Image : UIImage, isRounded : Bool){
        
        var x : CGFloat = 5
        var width : CGFloat = 40
        
        if isRounded{
            
            self.RoundMe(Radius: nil)
            
            if Postion == .left{
                x = 20
            }else{
                x = 10
            }
            width = width + 20
        }else{
            x = 5
        }
        
        let iconView = UIImageView(frame:
            CGRect(x: x, y: 0, width: 30, height: self.frame.height))
        
        iconView.image = Image
        iconView.contentMode = .scaleAspectFit
        
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        
        iconContainerView.addSubview(iconView)
        
        if Postion == .left{
            leftView = iconContainerView
            leftViewMode = .always
        }else{
            rightView = iconContainerView
            rightViewMode =  .always
        }
    }
    
    /// This function will set an button icon to the specfied position for both boxed and round edges TextField
    /// -  if isRounded is true the the textfield will be autometically gets rounded
    /// - you can always override the corner radius property
    /// - parameter Postion : Position of the icon in textfield
    /// - parameter Image : Icon asset you want to set
    /// - parameter isRounded : if textfield is rounded or not
    /// - parameter Action : Action selector you wanted to perform
    /// - parameter target : Target for UIButton, mostly self or nil.
    func SetButton(Postion : Location, Image : UIImage, isRounded : Bool, Action : Selector, target : Any?){
        
        var x : CGFloat = 5
        var width : CGFloat = 40
        
        if isRounded{
            
            self.RoundMe(Radius: nil)
            
            if Postion == .left{
                x = 20
            }else{
                x = 10
            }
            width = width + 20
        }else{
            x = 5
        }
        
        let Button = UIButton(frame:
            CGRect(x: x, y: 0, width: 30, height: self.frame.height))
        
        Button.setImage(Image, for: .normal)
        
        Button.imageView?.contentMode = .scaleAspectFit
        
        Button.addTarget(target, action: Action, for: .touchUpInside)
        
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        
        iconContainerView.addSubview(Button)
        
        if Postion == .left{
            leftView = iconContainerView
            leftViewMode = .always
        }else{
            rightView = iconContainerView
            rightViewMode =  .always
        }
        
    }
    
    /// This function will block the white space inputs of the text while editing
    /// - editingChanged targeted for this method if in case you decide to override this won't work or yours won't work.
    func DisableWhiteSpaceInput(){
        self.addTarget(self, action: #selector(TextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func TextFieldDidChange(_ textField: UITextField){
        if textField.text?.containsWhitespace == true{
            textField.deleteBackward()
        }
    }
    
    /// This function will change color of your placeholder
    /// - this function will return NSMutableAttributedString if you wanted to add ant other attributes
    /// - parameter color: Color you wanted for the placeholder
    /// - returns: NSMutableAttributedString
    func ColorMyPlaceHolder(color : UIColor) -> NSMutableAttributedString{
        var myMutableStringTitle = NSMutableAttributedString()

        if let text = self.placeholder{
            myMutableStringTitle = NSMutableAttributedString(string: text)
            
            myMutableStringTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range:NSRange(location:0,length:text.count))
            
            self.attributedPlaceholder = myMutableStringTitle
            
        }
            
        return myMutableStringTitle
    }
}

extension UIDevice {
    static let MymodelName: String = {
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
               case "iPod5,1":                                 return "0"
               case "iPod7,1":                                 return "0"
               case "iPod9,1":                                 return "0"
               case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "0"
               case "iPhone4,1":                               return "0"
               case "iPhone5,1", "iPhone5,2":                  return "0"
               case "iPhone5,3", "iPhone5,4":                  return "0"
               case "iPhone6,1", "iPhone6,2":                  return "0"
               case "iPhone7,2":                               return "0"
               case "iPhone7,1":                               return "0"
               case "iPhone8,1":                               return "0"
               case "iPhone8,2":                               return "0"
               case "iPhone9,1", "iPhone9,3":                  return "0"
               case "iPhone9,2", "iPhone9,4":                  return "0"
               case "iPhone8,4":                               return "0"
               case "iPhone10,1", "iPhone10,4":                return "0"
               case "iPhone10,2", "iPhone10,5":                return "0"
               case "iPhone10,3", "iPhone10,6":                return "40"
               case "iPhone11,2":                              return "40"
               case "iPhone11,4", "iPhone11,6":                return "40"
               case "iPhone11,8":                              return "40"
               case "iPhone12,1":                              return "40"
               case "iPhone12,3":                              return "40"
               case "iPhone12,5":                              return "40"
               case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
               case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
               case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
               case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
               case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
               case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
               case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
               case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
               case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
               case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
               case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
               case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
               case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
               case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
               case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
               case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
               case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
               case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
               case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
               case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
               case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
               case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
               case "AppleTV5,3":                              return "Apple TV"
               case "AppleTV6,2":                              return "Apple TV 4K"
               case "AudioAccessory1,1":                       return "HomePod"
               case "i386", "x86_64":                          return "\(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
               default:                                        return identifier
               }
               #elseif os(tvOS)
               switch identifier {
               case "AppleTV5,3": return "Apple TV 4"
               case "AppleTV6,2": return "Apple TV 4K"
               case "i386", "x86_64": return "\(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
               default: return identifier
               }
               #endif
           }

           return mapToDevice(identifier: identifier)
       }()
}

extension UIViewController{
    
    ///This function will setup a navbar item with action, title, icon whatever you like everything is optional.
    /// - if tint color is nil and icon is not nil then icon will be shown as its original colors
    /// - you can pass any size of icon it will be autometically rezied to 20X20
    /// - Target can be set as nil or self make sure you just don't crash the app
    /// - parameter Position : Position of item you wanted left or right
    /// - parameter Title : if no icon and just text hop in
    /// - parameter Icon : UIImage for the item
    /// - parameter TintColor : tintcolor of theitem
    /// - parameter Action : action you would like to perform on click
    /// - parameter Target : target can be self or nil
    func SetNavBarItem(Position : Location, Title : String?,Icon : UIImage?, TintColor : UIColor?, Action : Selector?, Target : Any?){
        
        let image = Icon?.resize(withSize: CGSize(width: 30, height: 30), contentMode: .contentAspectFill)

        var button1 : UIBarButtonItem!
            
        if TintColor == nil{
            
            button1 = UIBarButtonItem(image: image?.withRenderingMode(.alwaysOriginal), style: .plain, target: Target, action:Action)
        }else{
            button1 = UIBarButtonItem(image: image, style: .plain, target: Target, action:Action)
            
            button1.tintColor = TintColor
        }
                    
        button1.title = Title
        
        switch Position {
        case .left:
            self.navigationItem.leftBarButtonItem  = button1
        case .right:
            self.navigationItem.rightBarButtonItem  = button1
        }
        
    }
    /// This function will dimiss or pop the current view controller
    @objc func GoBack(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    /// Returns a bool if device hase rounded edges or not
    /// - Devices UpTo ios13
    func isNotched() -> Bool {
        if UIDevice.MymodelName == "40"{
            return true
        }else{
            return false
        }
    }
    
    ///Will return the height of the bottom baar
    var BottomBarHeight: CGFloat {
    
     return self.tabBarController?.tabBar.frame.height ?? 0

    }
    
    /// will return the height of the navigation bar including status bar
    var navigationBarHeight: CGFloat {
    
     return UIApplication.shared.statusBarFrame.size.height +
         (self.navigationController?.navigationBar.frame.height ?? 0.0)

    }
    
    /// This will show an alert and start editing the provided textField as soon as user clicks on OK
    /// - parameter Message : Message You want to show to the user
    /// - parameter textField : textField you wants to make the first responsder
    func ShowTextFieldAlert(Message : String, textField : UITextField){
        let alert = UIAlertController(title: Message, message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (ALERT) in
            textField.becomeFirstResponder()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /// This will show an alert and start editing the provided textView as soon as user clicks on OK
    /// - parameter Message : Message You want to show to the user
    /// - parameter textView : textView you wants to make the first responsder
     func ShowTextViewAlert(Message : String, textView : UITextView){
           let alert = UIAlertController(title: Message, message: "", preferredStyle: .alert)
           
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (ALERT) in
               textView.becomeFirstResponder()
           }))
           
           self.present(alert, animated: true, completion: nil)
       }
    
    /// This will show an simple alert with a message
    /// - parameter Message : Message You want to show to the user
    func showSimpleAlert(Message : String){
        let alert = UIAlertController(title: Message, message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// This will show an simple alert with a message and pop or dismiss the current ViewController
    /// - parameter Message : Message You want to show to the user
    func ShowAlertAndGoBack(Message : String){
        let alert = UIAlertController(title: Message, message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (ALERT) in
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /// This will show an simple alert with a message and push the view controller
    /// - parameter id : id of the view controller you wanted to push
    /// - parameter Message : Message You want to show to the user
    /// - parameter Style : Style you wants either present or push the View Controller
    func ShowAlertAndGoTo(id : String, Message : String, Style : ShowStyle){
        let alert = UIAlertController(title: Message, message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (ALERT) in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: id)
            
            switch Style{
            case .Push:
                self.navigationController?.pushViewController(vc, animated: true)
            case .Present:
                self.present(vc, animated: true, completion: nil)
            }

        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /// This function will show an alert and perform action after user clicks on button
    /// - action nil will only display alert with message use SimpleAlert functiion for that.
    /// - parameter Message : Message you wanted to display
    /// - parameter action : Action will
    func showAlertAndPerform(Message : String, action : ((UIAlertAction) -> Void)?){
        
        let alert = UIAlertController(title: Message, message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: action))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    /// This Function will autometically manages the respondings of textFields
    /// - Important  : Make sure you follow all the below protocols to execute the function
    /// - make sure you have set delegates in all textFields
    /// - make sure you confroms to the UITextFieldDelegate
    /// - make sure you are executing this function inside textFieldShouldReturn(_:)
    /// - The sequence will be followed as provided in the array of textField parameter
    /// - parameter textFields : Array of textFields you wanted to enable the the function
    func autoReturnResponder(textFields : [UITextField]){
        for i in 0..<textFields.count{
            
            if textFields[i].isFirstResponder && i < textFields.count - 1{
                textFields[i + 1].becomeFirstResponder()
                break
            }else if textFields[i].isFirstResponder && i == textFields.count - 1{
                textFields[i].resignFirstResponder()
                break
            }
        }
    }
    
    ///This Function vill add gradient layer at ) index of the UIView
    /// - colors will be in sequence provided index vise
    /// - parameter Direction : Direction will define the direction of gradient flow
    /// - parameter Colors : Array of CGColors You wanted to make garient of
    /// - parameter Frame: Frame of the gradient layer you want
    /// - returns: CAGradientLayer
    func MakeGradientLayer(Direction : GradientDirection, Colors : [CGColor], Frame : CGRect) -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Colors
        
        if Direction == .Horizontal{
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        }else{
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        }
        gradientLayer.frame = Frame
        
        return gradientLayer
    }
    
    /// This fucntion will add tap gesture in your view whic will hide keyboard on screen tap
    func HideKeyboardOnTouches(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
    }
    
    /// Hides Keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension UITabBarController{
    /// This Function is for long tap gesture which will convert the X location
    /// - returns: Integer indication the selected Index
    /// - parameter GestureLocationX: X postion of the touch
    /// - parameter width: width of your tab bar
    /// - note: How can you get X:
    /// - let translation = sender.location(in: sender.view):
    /// - let touchLoction = translation.x
    func selectedIndexForTabbar(GestureLocationX : CGFloat, width : CGFloat) -> Int{
        
        let div1 = 0..<width/5
        let div2 = div1.upperBound...(div1.upperBound * 2)
        let div3 = div2.upperBound...(div1.upperBound * 3)
        let div4 = div3.upperBound...(div1.upperBound * 4)
        
        if div1.contains(GestureLocationX){
            return 1
        }else if div2.contains(GestureLocationX){
            return 2
        }else if div3.contains(GestureLocationX){
            return 3
        }else if div4.contains(GestureLocationX){
            return 4
        }else{
            return 5
        }
        
    }
}

extension Int{
    /// returns the string by converting mins into past
    func ConvertMin() -> String{
        let min = self
        
        if min > 60{
            let hour = min / 60
            
            if hour > 24 {
                let day = hour / 24
                return "\(String(day)) day"
            }else{
            return "\(String(hour)) hour"
            }
        }else{
            return "\(String(min)) min"
        }
    }
    
    /// Will short the integer into string like K,M
    /// - will transform the long int to human readable string
    /// - 1000 = 1K
    /// - 1000000 = 1M
    /// - returns: sorted string
    func sortedString() -> String {
        if self >= 1000 && self < 10000 {
            return String(format: "%.1fK", Double(self/100)/10).replacingOccurrences(of: ".0", with: "")
        }

        if self >= 10000 && self < 1000000 {
            return "\(self/1000)k"
        }

        if self >= 1000000 && self < 10000000 {
            return String(format: "%.1fM", Double(self/100000)/10).replacingOccurrences(of: ".0", with: "")
        }

        if self >= 10000000 && self < 1000000000{
            return "\(self/1000000)M"
        }

        if self >= 1000000000 {
            return "\(self/1000000000)B"
        }
        
        return String(self)
    }
    
}

extension UINavigationController {
    
    /// Go Back to the perticular one of the view parent controllers of current view controller
    /// - parameter vc : Provide a UIIViewController where you'd like to go back to
    func backToViewController(vc: Any) {
        // iterate to find the type of vc
        for element in viewControllers as Array {
            if "\(type(of: element)).Type" == "\(type(of: vc))" {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
    
    /// This function will make your navigation bar transperent
    /// - set navigationBar.isTranslucent to false far restore it
    func TransperantNavigationBar(){
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true

    }
    
    ///replace your top view controller with the specific view controller
    /// - parameter viewController: view controller to replace
    /// - parameter animated: animate the change or not
    func replaceTopViewController(with viewController: UIViewController, animated: Bool) {
      var vcs = viewControllers
      vcs[vcs.count - 1] = viewController
      setViewControllers(vcs, animated: animated)
    }
}

extension WKWebView {
    /// This  function will autometically creates the the url requests and will load the url inside the WebView
    /// - parameter urlString : URL in string you wanted to load
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}

extension UITableViewCell{
    
    enum DGCellAnimationType{
        case LargeScale, LowScale, MedScale, CrossDissolve, Bounce, SlideIn
    }
    
    /// This Function will animate the cells of the UITableView
    /// - the effect of this is depend where you call it
    /// -  you can call this method in both cellForRowAt(_ :) or tableView(_:willDisplay:forRowAt:)
    /// - you can handle the time you wanted the program run with the help of completionHandler
    /// - parameter AnimationType: The type of animation you like for the cell
    /// - parameter withOpacity: Opacity will also animate the alpha of the cell which will gives an extra ordinary animation to smoothen the animation
    /// - parameter indexPath: some animations are based on the indexPath which will animate them one after another
    /// - parameter completionHandler: Completion handler will allow you to do some task after the animations are over. default is nil.
    func AnimateCell(AnimationType : DGCellAnimationType, withOpacity : Bool, indexPath : IndexPath, completionHandler: ((Bool) -> Void)? = nil){
        
        if withOpacity{
            self.alpha = 0
        }
        
        switch AnimationType {
        case .LargeScale:
            self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
            UIView.animate(withDuration: 0.3, animations: {
                self.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1)
                self.alpha = 1
            },completion: { finished in
                UIView.animate(withDuration: 0.1, animations: {
                    self.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }, completion: completionHandler)
            })
        case .LowScale:
            
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            UIView.animate(withDuration: 0.4, animations: {
                self.transform = CGAffineTransform.identity
                self.alpha = 1
            }, completion: completionHandler)
            
        case .MedScale:
            
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
            UIView.animate(withDuration: 0.4, animations: {
                self.transform = CGAffineTransform.identity
                self.alpha = 1
            }, completion: completionHandler)
            
        case .CrossDissolve:
            
            UIView.animate(withDuration: 0.5, delay: 0.5 * Double(indexPath.row), options: .curveEaseInOut, animations: {
                self.alpha = 1
            }, completion: completionHandler)

        case .Bounce:
            self.transform = CGAffineTransform(translationX: 0, y: self.frame.height)

            UIView.animate(
                withDuration: 0.3,
                delay: 0.05 * Double(indexPath.row),
                usingSpringWithDamping: 0.4,
                initialSpringVelocity: 0.1,
                options: [.curveEaseInOut],
                animations: {
                    self.alpha = 1
                    self.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: completionHandler)
            
        case .SlideIn:
            self.transform = CGAffineTransform(translationX: self.superview?.bounds.width ?? UIScreen.main.bounds.width, y: 0)

            UIView.animate(
                withDuration: 0.3,
                delay: 0.05 * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    self.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: completionHandler)
        }

    }
}

extension UITableView{
    ///This function will reload data and will shows the animations as cross dissolve
    func AnimatedReloadData(){
         UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {self.reloadData()}, completion: nil)
    }
    
    ///This function will scroll the table view to the very bottom of tableView
    /// - parameter animated: if you want the scroll animated or not
    func scrollToBottom(animated : Bool){

        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
        }
    }
    
    ///This function will scroll the table view to the very top of tableView
    /// - parameter animated: if you want the scroll animated or not
    func scrollToTop(animated : Bool) {

        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
    
    /// This function will set an empty message for your collection in very center of the view
    /// - note: use restore() function to remove the message
    /// - parameter message: Message you wanted to show
    /// - parameter font: font of the text
    /// - parameter textColor: color of text
    func setEmptyMessage(_ message: String, font: UIFont?, textColor: UIColor?) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;

        messageLabel.font = font ?? UIFont.systemFont(ofSize: 23)
        messageLabel.textColor = textColor ?? UIColor.gray
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    /// restore empty message
    func restore() {
        self.backgroundView = nil
    }
}

extension UICollectionView{
    ///This function will reload data and will shows the animations as cross dissolve
    func AnimatedReloadData(){
         UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {self.reloadData()}, completion: nil)
    }
    
    /// This function will set an empty message for your collection in very center of the view
    /// - note: use restore() function to remove the message
    /// - parameter message: Message you wanted to show
    /// - parameter font: font of the text
    /// - parameter textColor: color of text
    func setEmptyMessage(_ message: String,  font : UIFont?, textColor : UIColor?) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        
        messageLabel.font = font ?? UIFont.systemFont(ofSize: 25)
        messageLabel.textColor = textColor ?? UIColor.lightGray
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}

extension UISearchBar {

    ///Enables the Cancle button of search bar when you call
    /// - call when user begin the search
    func enableCancelButton(in view: UIView) {

        view.subviews.forEach {
            enableCancelButton(in: $0)
        }

        if let cancelButton = view as? UIButton {
            cancelButton.isEnabled = true
            cancelButton.isUserInteractionEnabled = true
        }
    }
}

extension NSMutableAttributedString{
    /// This function will helps you to append another attributed string after on another
    /// -  parameter attributedString: the string which will append the current one
    func append(attributedString:NSMutableAttributedString) -> NSMutableAttributedString{
        let newAttributedString = NSMutableAttributedString()
        newAttributedString.append(self)
        newAttributedString.append(attributedString)
        return newAttributedString
    }
    
    /// Color the perticular text using serach text method
    /// - parameter textToFind: Text To Color
    /// - parameter color: Color You want to Colorizw
    func setColorForText(_ textToFind: String, with color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }
}

extension CGFloat{
    /// Will return the Current iOS version of the device in CGFload
    func iOSVersion() -> CGFloat{
        
        let f = (UIDevice.current.systemVersion as NSString).floatValue
        
        
        return CGFloat(f)
    }
}
extension UIRefreshControl {
    /// It will manually pull the refresh control in scrollview to show to the user
    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
        }
        beginRefreshing()
    }
}
extension Data {
    /// This function will return the hex String of the data
    /// - useful for token conversions
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
