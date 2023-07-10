//
//  ListRow.swift
//  Smartway_TZ
//
//  Created by Pavel Krivtsov on 10.07.2023.
//

import SwiftUI

struct ListRow: View {
    
    let item: Photo
    
    var body: some View {
        HStack {
            VStack {
                Text(item.createdAt)
                    .font(.title)
                    .foregroundColor(.blue)
                Spacer()
                Text(item.id)
            }
        }
    }
}
