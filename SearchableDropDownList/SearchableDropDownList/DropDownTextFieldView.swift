//
//  DropDownListView.swift
//  SearchableDropDownList
//
//  Created by Elavenil Elanchelian on 2023-02-10.
//

import SwiftUI

struct DropDownLTextFieldView: View {
    
    @State var searchText: String = ""
    @State var isOptionsPresented: Bool = false
    var dropDownOptions: [String] = ["India","US","Canada","Italy","France","Spain","TamilNadu","Europe"]
    
    
    var body: some View {
        TextField("Search", text: $searchText, onEditingChanged: { changed in
            self.isOptionsPresented = changed
        },onCommit: {
            self.isOptionsPresented = false
        } )
        .id("StoreTextField")
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
        }
        .overlay(alignment: .top) {
            VStack {
                if self.isOptionsPresented {
                    Spacer(minLength: 60)
                    DropdownMenuList(options: dropDownOptions, searchData: $searchText) { option in
                        self.isOptionsPresented = false
                        searchText = option.uppercased()
                    }
                }
            }
        }
        .padding(.bottom, self.isOptionsPresented ?  getListViewHeight(list: dropDownOptions, searchData: searchText) : 0)
    }
    
    func getListViewHeight(list: [String], searchData: String) -> CGFloat {
        var option: [String] = []
       option = list.filter {
           searchData.isEmpty || $0.uppercased().contains(searchData)  }
        return CGFloat(option.count * 32 > 100 ? 100 : option.count * 32)
    }
}


