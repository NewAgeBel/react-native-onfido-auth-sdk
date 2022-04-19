import Foundation
#if !targetEnvironment(simulator)
import OnfidoAuth

/**
 * Load appearance data from the specified file. If the file cannot be loaded, use the default values.
 */
public func loadAppearanceFromFile(filePath: String?) throws -> OnfidoAuthAppearance {

  do {
    let jsonResult:Any
    do {
      guard let path = filePath else { return OnfidoAuthAppearance() }
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
    } catch let e as NSError where e.code == NSFileNoSuchFileError || e.code == NSFileReadNoSuchFileError {
      jsonResult = Dictionary<String, AnyObject>()
    }
    if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
      return OnfidoAuthAppearance(
        primaryTextColor: UIColor.from(hex: jsonResult["onfidoPrimaryTextColor"] as? String),
        primaryTextDynamicDimmingColor: UIColor.from(hex: jsonResult["onfidoPrimaryTextDynamicDimmingColor"] as? String),
        primaryButtonColor: UIColor.from(hex: jsonResult["onfidoPrimaryButtonColor"] as? String),
        primaryButtonDynamicDimmingColor: UIColor.from(hex: jsonResult["onfidoPrimaryButtonDynamicDimmingColor"] as? String),
        primaryButtonPressedColor: UIColor.from(hex: jsonResult["onfidoPrimaryButtonPressedColor"] as? String),
        primaryButtonDisabledColor: UIColor.from(hex: jsonResult["onfidoPrimaryButtonDisabledColor"] as? String),
        primaryButtonDisabledDynamicDimmingColor: UIColor.from(hex: jsonResult["onfidoPrimaryButtonDisabledDynamicDimmingColor"] as? String),
        primaryButtonTextColor: UIColor.from(hex: jsonResult["onfidoPrimaryButtonTextColor"] as? String),
        primaryButtonTextDynamicDimmingColor: UIColor.from(hex: jsonResult["onfidoPrimaryButtonTextDynamicDimmingColor"] as? String),
        primaryButtonTextPressedColor: UIColor.from(hex: jsonResult["onfidoPrimaryButtonTextPressedColor"] as? String),
        primaryButtonTextDisabledColor: UIColor.from(hex: jsonResult["onfidoPrimaryButtonTextDisabledColor"] as? String),
        primaryButtonTextDisabledDynamicDimmingColor: UIColor.from(hex: jsonResult["onfidoPrimaryButtonTextDisabledDynamicDimmingColor"] as? String),
        secondaryButtonPressedColor: UIColor.from(hex: jsonResult["onfidoSecondaryButtonPressedColor"] as? String),
        dualSpinnerColor: UIColor.from(hex: jsonResult["onfidoDualSpinnerColor"] as? String),
        retryScreenOvalStrokeColor: UIColor.from(hex: jsonResult["onfidoRetryScreenOvalStrokeColor"] as? String),
        uploadProgressFillColor: UIColor.from(hex: jsonResult["onfidoUploadProgressFillColor"] as? String),
        buttonCornerRadius: jsonResult["onfidoButtonCornerRadius"] as? CGFloat,
        fontRegular: jsonResult["onfidoFontRegular"] as? String,
        fontMedium: jsonResult["onfidoFontMedium"] as? String,
        fontBold: jsonResult["onfidoFontBold"] as? String
      )
    } else {
      return OnfidoAuthAppearance()
    }
  } catch let error {
    throw NSError(domain: "There was an error setting colors for OnfidoAuthAppearance: \(error)", code: 0)
  }
}

extension UIColor {

  static func from(hex: String?) -> UIColor? {
    guard let hex = hex else {
      return nil
    }

    let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    let scanner = Scanner(string: hexString)

    if hexString.hasPrefix("#") {
      scanner.scanLocation = 1
    }

    var color: UInt32 = 0
    scanner.scanHexInt32(&color)

    let mask = 0x000000FF
    let redInt = Int(color >> 16) & mask
    let greenInt = Int(color >> 8) & mask
    let blueInt = Int(color) & mask

    let red = CGFloat(redInt) / 255.0
    let green = CGFloat(greenInt) / 255.0
    let blue = CGFloat(blueInt) / 255.0

    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
  }
}
#endif
