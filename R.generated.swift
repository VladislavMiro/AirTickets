//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var info: info { .init(bundle: bundle) }
  var font: font { .init(bundle: bundle) }
  var file: file { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func info(bundle: Foundation.Bundle) -> info {
    .init(bundle: bundle)
  }
  func font(bundle: Foundation.Bundle) -> font {
    .init(bundle: bundle)
  }
  func file(bundle: Foundation.Bundle) -> file {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.font.validate()
    try self.storyboard.validate()
  }

  struct project {
    let developmentRegion = "ru"
  }

  /// This `_R.color` struct is generated, and contains static references to 16 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }

    /// Color `BackgroundBlackColor`.
    var backgroundBlackColor: RswiftResources.ColorResource { .init(name: "BackgroundBlackColor", path: [], bundle: bundle) }

    /// Color `blueTintColor`.
    var blueTintColor: RswiftResources.ColorResource { .init(name: "blueTintColor", path: [], bundle: bundle) }

    /// Color `darkBlue`.
    var darkBlue: RswiftResources.ColorResource { .init(name: "darkBlue", path: [], bundle: bundle) }

    /// Color `darkGreen`.
    var darkGreen: RswiftResources.ColorResource { .init(name: "darkGreen", path: [], bundle: bundle) }

    /// Color `greenTintColor`.
    var greenTintColor: RswiftResources.ColorResource { .init(name: "greenTintColor", path: [], bundle: bundle) }

    /// Color `grey1`.
    var grey1: RswiftResources.ColorResource { .init(name: "grey1", path: [], bundle: bundle) }

    /// Color `grey2`.
    var grey2: RswiftResources.ColorResource { .init(name: "grey2", path: [], bundle: bundle) }

    /// Color `grey3`.
    var grey3: RswiftResources.ColorResource { .init(name: "grey3", path: [], bundle: bundle) }

    /// Color `grey4`.
    var grey4: RswiftResources.ColorResource { .init(name: "grey4", path: [], bundle: bundle) }

    /// Color `grey5`.
    var grey5: RswiftResources.ColorResource { .init(name: "grey5", path: [], bundle: bundle) }

    /// Color `grey6`.
    var grey6: RswiftResources.ColorResource { .init(name: "grey6", path: [], bundle: bundle) }

    /// Color `grey7`.
    var grey7: RswiftResources.ColorResource { .init(name: "grey7", path: [], bundle: bundle) }

    /// Color `orangeTintColor`.
    var orangeTintColor: RswiftResources.ColorResource { .init(name: "orangeTintColor", path: [], bundle: bundle) }

    /// Color `redTintColor`.
    var redTintColor: RswiftResources.ColorResource { .init(name: "redTintColor", path: [], bundle: bundle) }

    /// Color `whiteTextColor`.
    var whiteTextColor: RswiftResources.ColorResource { .init(name: "whiteTextColor", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 29 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `City1`.
    var city1: RswiftResources.ImageResource { .init(name: "City1", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `City2`.
    var city2: RswiftResources.ImageResource { .init(name: "City2", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `City3`.
    var city3: RswiftResources.ImageResource { .init(name: "City3", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `bed`.
    var bed: RswiftResources.ImageResource { .init(name: "bed", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `bell`.
    var bell: RswiftResources.ImageResource { .init(name: "bell", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `calendar`.
    var calendar: RswiftResources.ImageResource { .init(name: "calendar", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `close`.
    var close: RswiftResources.ImageResource { .init(name: "close", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `cover1`.
    var cover1: RswiftResources.ImageResource { .init(name: "cover1", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `cover2`.
    var cover2: RswiftResources.ImageResource { .init(name: "cover2", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `cover3`.
    var cover3: RswiftResources.ImageResource { .init(name: "cover3", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `earth`.
    var earth: RswiftResources.ImageResource { .init(name: "earth", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `fire`.
    var fire: RswiftResources.ImageResource { .init(name: "fire", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `graph`.
    var graph: RswiftResources.ImageResource { .init(name: "graph", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `human`.
    var human: RswiftResources.ImageResource { .init(name: "human", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `includeMark`.
    var includeMark: RswiftResources.ImageResource { .init(name: "includeMark", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `landmark`.
    var landmark: RswiftResources.ImageResource { .init(name: "landmark", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `leftArrow`.
    var leftArrow: RswiftResources.ImageResource { .init(name: "leftArrow", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `notification`.
    var notification: RswiftResources.ImageResource { .init(name: "notification", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `plane`.
    var plane: RswiftResources.ImageResource { .init(name: "plane", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `plane2`.
    var plane2: RswiftResources.ImageResource { .init(name: "plane2", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `plus`.
    var plus: RswiftResources.ImageResource { .init(name: "plus", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `profile`.
    var profile: RswiftResources.ImageResource { .init(name: "profile", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `replaceArrows`.
    var replaceArrows: RswiftResources.ImageResource { .init(name: "replaceArrows", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `rightArrow`.
    var rightArrow: RswiftResources.ImageResource { .init(name: "rightArrow", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `route`.
    var route: RswiftResources.ImageResource { .init(name: "route", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `search`.
    var search: RswiftResources.ImageResource { .init(name: "search", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `settings`.
    var settings: RswiftResources.ImageResource { .init(name: "settings", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `share`.
    var share: RswiftResources.ImageResource { .init(name: "share", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `toolTip`.
    var toolTip: RswiftResources.ImageResource { .init(name: "toolTip", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    let bundle: Foundation.Bundle
    var uiApplicationSceneManifest: uiApplicationSceneManifest { .init(bundle: bundle) }

    func uiApplicationSceneManifest(bundle: Foundation.Bundle) -> uiApplicationSceneManifest {
      .init(bundle: bundle)
    }

    struct uiApplicationSceneManifest {
      let bundle: Foundation.Bundle

      let uiApplicationSupportsMultipleScenes: Bool = false

      var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest"], key: "_key") ?? "UIApplicationSceneManifest" }
      var uiSceneConfigurations: uiSceneConfigurations { .init(bundle: bundle) }

      func uiSceneConfigurations(bundle: Foundation.Bundle) -> uiSceneConfigurations {
        .init(bundle: bundle)
      }

      struct uiSceneConfigurations {
        let bundle: Foundation.Bundle
        var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations"], key: "_key") ?? "UISceneConfigurations" }
        var uiWindowSceneSessionRoleApplication: uiWindowSceneSessionRoleApplication { .init(bundle: bundle) }

        func uiWindowSceneSessionRoleApplication(bundle: Foundation.Bundle) -> uiWindowSceneSessionRoleApplication {
          .init(bundle: bundle)
        }

        struct uiWindowSceneSessionRoleApplication {
          let bundle: Foundation.Bundle
          var defaultConfiguration: defaultConfiguration { .init(bundle: bundle) }

          func defaultConfiguration(bundle: Foundation.Bundle) -> defaultConfiguration {
            .init(bundle: bundle)
          }

          struct defaultConfiguration {
            let bundle: Foundation.Bundle
            var uiSceneConfigurationName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneConfigurationName") ?? "Default Configuration" }
            var uiSceneDelegateClassName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate" }
          }
        }
      }
    }
  }

  /// This `_R.font` struct is generated, and contains static references to 3 fonts.
  struct font: Sequence {
    let bundle: Foundation.Bundle

    /// Font `SFProDisplay-Medium`.
    var sfProDisplayMedium: RswiftResources.FontResource { .init(name: "SFProDisplay-Medium", bundle: bundle, filename: "SF-Pro-Display-Medium.otf") }

    /// Font `SFProDisplay-Regular`.
    var sfProDisplayRegular: RswiftResources.FontResource { .init(name: "SFProDisplay-Regular", bundle: bundle, filename: "SF-Pro-Display-Regular.otf") }

    /// Font `SFProDisplay-Semibold`.
    var sfProDisplaySemibold: RswiftResources.FontResource { .init(name: "SFProDisplay-Semibold", bundle: bundle, filename: "SF-Pro-Display-Semibold.otf") }

    func makeIterator() -> IndexingIterator<[RswiftResources.FontResource]> {
      [sfProDisplayMedium, sfProDisplayRegular, sfProDisplaySemibold].makeIterator()
    }
    func validate() throws {
      for font in self {
        if !font.canBeLoaded() { throw RswiftResources.ValidationError("[R.swift] Font '\(font.name)' could not be loaded, is '\(font.filename)' added to the UIAppFonts array in this targets Info.plist?") }
      }
    }
  }

  /// This `_R.file` struct is generated, and contains static references to 4 resource files.
  struct file {
    let bundle: Foundation.Bundle

    /// Resource file `SF-Pro-Display-Medium.otf`.
    var sfProDisplayMediumOtf: RswiftResources.FileResource { .init(name: "SF-Pro-Display-Medium", pathExtension: "otf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `SF-Pro-Display-Regular.otf`.
    var sfProDisplayRegularOtf: RswiftResources.FileResource { .init(name: "SF-Pro-Display-Regular", pathExtension: "otf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `SF-Pro-Display-Semibold.otf`.
    var sfProDisplaySemiboldOtf: RswiftResources.FileResource { .init(name: "SF-Pro-Display-Semibold", pathExtension: "otf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `gitignore`.
    var gitignore: RswiftResources.FileResource { .init(name: "gitignore", pathExtension: "", bundle: bundle, locale: LocaleReference.none) }
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var launchScreen: launchScreen { .init(bundle: bundle) }

    func launchScreen(bundle: Foundation.Bundle) -> launchScreen {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.launchScreen.validate()
    }


    /// Storyboard `LaunchScreen`.
    struct launchScreen: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UIViewController

      let bundle: Foundation.Bundle

      let name = "LaunchScreen"
      func validate() throws {

      }
    }
  }
}