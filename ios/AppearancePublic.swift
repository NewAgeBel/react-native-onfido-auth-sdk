public class AppearancePublic: NSObject {

  public let primaryTextColor: UIColor?
  public let primaryTextDynamicDimmingColor: UIColor?
  public let primaryButtonColor: UIColor?
  public let primaryButtonDynamicDimmingColor: UIColor?
  public let primaryButtonPressedColor: UIColor?
  public let primaryButtonDisabledColor: UIColor?
  public let primaryButtonDisabledDynamicDimmingColor: UIColor?
  public let primaryButtonTextColor: UIColor?
  public let primaryButtonTextDynamicDimmingColor: UIColor?
  public let primaryButtonTextPressedColor: UIColor?
  public let primaryButtonTextDisabledColor: UIColor?
  public let primaryButtonTextDisabledDynamicDimmingColor: UIColor?
  public let secondaryButtonPressedColor: UIColor?
  public let dualSpinnerColor: UIColor?
  public let retryScreenOvalStrokeColor: UIColor?
  public let uploadProgressFillColor: UIColor?
  public let buttonCornerRadius: CGFloat?
  public let fontRegular: String?
  public let fontMedium: String? 
  public let fontBold: String?

  public init(
    primaryTextColor: UIColor?,
    primaryTextDynamicDimmingColor: UIColor?,
    primaryButtonColor: UIColor?,
    primaryButtonDynamicDimmingColor: UIColor?,
    primaryButtonPressedColor: UIColor?,
    primaryButtonDisabledColor: UIColor?,
    primaryButtonDisabledDynamicDimmingColor: UIColor?,
    primaryButtonTextColor: UIColor?,
    primaryButtonTextDynamicDimmingColor: UIColor?,
    primaryButtonTextPressedColor: UIColor?,
    primaryButtonTextDisabledColor: UIColor?,
    primaryButtonTextDisabledDynamicDimmingColor: UIColor?,
    secondaryButtonPressedColor: UIColor?,
    dualSpinnerColor: UIColor?,
    retryScreenOvalStrokeColor: UIColor?,
    uploadProgressFillColor: UIColor?,
    buttonCornerRadius: CGFloat?,
    fontRegular: String?,
    fontMedium: String?, 
    fontBold: String?) {
    self.primaryTextColor = primaryTextColor
    self.primaryTextDynamicDimmingColor = primaryTextDynamicDimmingColor
    self.primaryButtonColor = primaryButtonColor
    self.primaryButtonDynamicDimmingColor = primaryButtonDynamicDimmingColor
    self.primaryButtonPressedColor = primaryButtonPressedColor
    self.primaryButtonDisabledColor = primaryButtonDisabledColor
    self.primaryButtonDisabledDynamicDimmingColor = primaryButtonDisabledDynamicDimmingColor
    self.primaryButtonTextColor = primaryButtonTextColor
    self.primaryButtonTextDynamicDimmingColor = primaryButtonTextDynamicDimmingColor
    self.primaryButtonTextPressedColor = primaryButtonTextPressedColor
    self.primaryButtonTextDisabledColor = primaryButtonTextDisabledColor
    self.primaryButtonTextDisabledDynamicDimmingColor = primaryButtonTextDisabledDynamicDimmingColor
    self.secondaryButtonPressedColor = secondaryButtonPressedColor
    self.dualSpinnerColor = dualSpinnerColor
    self.retryScreenOvalStrokeColor = retryScreenOvalStrokeColor
    self.uploadProgressFillColor = uploadProgressFillColor
    self.buttonCornerRadius = buttonCornerRadius
    self.fontRegular = fontRegular
    self.fontMedium = fontRegular
    self.fontBold = fontRegular
  }
}