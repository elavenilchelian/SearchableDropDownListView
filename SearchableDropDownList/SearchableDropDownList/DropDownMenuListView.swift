//
//  DropDownMenuListView.swift
//  SearchableDropDownList
//
//  Created by Elavenil Elanchelian on 2023-02-10.
//

import SwiftUI

struct DropdownMenuList: View {
    let options: [String]
    @Binding var searchData: String
    let onSelectedAction: (_ option: String) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 2) {
                ForEach(options.filter { searchData.isEmpty || $0.uppercased().contains(searchData.uppercased()) }, id: \.self) { option in
                    DropdownMenuListRow(option: option, onSelectedAction: self.onSelectedAction)
                }
            }
        }
        .frame(height: getListViewHeight(list: options, searchData: searchData))
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 2)
        }
    }
    
    func getListViewHeight(list: [String], searchData: String) -> CGFloat {
        var option: [String] = []
       option = list.filter {
            searchData.isEmpty || $0.contains(searchData.uppercased())  }
        return CGFloat(option.count * 32 > 100 ? 100 : option.count * 32)
    }
    
}

struct DropdownMenuListRow: View {
    let option: String
    let onSelectedAction: (_ option: String) -> Void
    
    var body: some View {
        Button(action: {
            self.onSelectedAction(option)
        }) {
            Text(verbatim:"\(option)")
                    .frame(maxWidth: .infinity, alignment: .leading)
   
        }
        .foregroundColor(.black)
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}
