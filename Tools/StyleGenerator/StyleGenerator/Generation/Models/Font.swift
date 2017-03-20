//
//  Font.swift
//  StyleGenerator
//
//  Created by Denis on 19.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Cocoa

// swiftlint:disable force_cast

struct FontsCollection: TemplateModel {

  // MARK: - Properties

  let fonts: [Font]

  // MARK: - Public

  init(_ parameters: TemplateInputParameters) {
    let fontsParameters = parameters["fonts"] as! [TemplateInputParameters]
    self.fonts = TemplateModelsFactory.makeModels(from: fontsParameters)
  }
}

struct Font: TemplateModel {

  // MARK: - Properties
  let name: String
  let font: String

  // MARK: - Public

  init(_ parameters: TemplateInputParameters) {
    guard let fontName = parameters["fontName"] as? String else {
      exit(with: "'fontName' parameter for Font doesn't exist as String")
      self.font = ""
      self.name = ""
      return
    }

    self.font = fontName
    self.name = type(of: self).generateName(from: self.font)
  }
}

extension Font {

  // MARK: - Private

  //Convert from "GothamPro-Light" -> "gothamProLight"
  fileprivate static func generateName(from font: String) -> String {
    if font.isEmpty {
      return ""
    }

    let firstChar = String(font.characters.prefix(1)).lowercased()
    let remainChars = String(font.characters.dropFirst()).replacingOccurrences(of: "-", with: "")

    return firstChar + remainChars
  }
}
