//
//  PriceView.swift
//  CodingChallengeSwiftUI
//
//  Created by Reginald on 12/2/20.
//

import SwiftUI

struct PriceView: View {
    let sdBuyPrice: String?
    let hdBuyPrice: String?
    let sdRentPrice: String?
    let hdRentPrice: String?
    let currency: String
    
    var isAvailableInSD: Bool {
        sdBuyPrice != nil || sdRentPrice != nil
    }
    
    var isAvailableInHD: Bool {
        hdBuyPrice != nil || hdRentPrice != nil
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if isAvailableInHD {
                PriceStackView(title: String.hd, buyPrice: hdBuyPrice, rentPrice: hdRentPrice, currency: currency)
                    .foregroundColor(.antiqueGold)
            }
            if isAvailableInSD {
                PriceStackView(title: String.sd, buyPrice: sdBuyPrice, rentPrice: sdRentPrice, currency: currency)
                    .foregroundColor(.blue)
            }
        }
        .font(.system(size: 10))
    }
}

struct PriceStackView: View {
    let title: String?
    let buyPrice: String?
    let rentPrice: String?
    let currency: String
        
    var body: some View {
        HStack {
            Text(title ?? "").fontWeight(.heavy)
            VStack(alignment: .trailing) {
                buyPrice.map({Text("\(String.buy) \($0) \(currency)").fontWeight(.bold)})
                rentPrice.map({Text("\(String.rent) \($0) \(currency)").fontWeight(.bold)})
            }
        }
    }
}

struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView(sdBuyPrice: "9.99",
                  hdBuyPrice: "19.99",
                  sdRentPrice: nil,
                  hdRentPrice: "4.99",
                  currency: "AUD")
        .previewLayout(.sizeThatFits)
    }
}
