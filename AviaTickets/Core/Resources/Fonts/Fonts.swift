//
//  Fonts.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 01.06.2024.
//

import UIKit

struct Fonts {
    static let title1 = R.font.sfProDisplaySemibold(size: 22) ?? .systemFont(ofSize: 22, weight: .semibold)
    static let title2 = R.font.sfProDisplaySemibold(size: 20) ?? .systemFont(ofSize: 20, weight: .semibold)
    static let title3 = R.font.sfProDisplayMedium(size: 16) ?? .systemFont(ofSize: 16, weight: .medium)
    static let title4 = R.font.sfProDisplayRegular(size: 14) ?? .systemFont(ofSize: 16, weight: .regular)
    static let text1 = R.font.sfProDisplayRegular(size: 16) ?? .systemFont(ofSize: 16, weight: .regular)
    static let text2 = R.font.sfProDisplayRegular(size: 14) ?? .systemFont(ofSize: 14, weight: .regular)
    static let buttonText1 = R.font.sfProDisplaySemibold(size: 16) ?? .systemFont(ofSize: 16, weight: .semibold)
    static let tabText = R.font.sfProDisplayRegular(size: 10) ?? .systemFont(ofSize: 10, weight: .regular)
}
