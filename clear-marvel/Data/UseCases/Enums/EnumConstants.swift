//
//  EnumConstants.swift
//  Data
//
//  Created by Marcos Barbosa on 17/10/21.
//

import Foundation

public enum UrlConstants: String {
    case baseURL = "https://gateway.marvel.com/v1/public/"
    case privateKey = "f0000cec83fc98ca79eadfca59eefa8ea61fbf23"
    case publicKey = "e635872de001202b9ede79b944413bdd"
}

public enum Portrait: String {
    case small = "portrait_small"
    case medium = "portrait_medium"
    case xlarge = "portrait_xlarge"
    case fantastic = "portrait_uncanny"
    case incredible = "portrait_incredible"
}

public enum Standard: String {
    case small = "standard_small"
    case medium = "standard_medium"
    case large = "standard_large"
    case xlarge = "standard_xlarge"
    case fantastic = "standard_fantastic"
    case amazing = "standard_amazing"
}

public enum Landscape: String {
    case small = "landscape_small"
    case medium = "landscape_medium"
    case large = "landscape_large"
    case xlarge = "landscape_xlarge"
    case amazing = "landscape_amazing"
    case incredible = "landscape_incredible"
}
