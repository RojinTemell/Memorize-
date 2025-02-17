//
//  ContentView.swift
//  Memorize!
//
//  Created by rojin on 17.02.2025.
//

// issue 1: Why change position of buttons ?
//issue 2: Why card's index that i tap face up other theme?

import SwiftUI
let themes: [String: (image: String, title: String,emojis: [String])] = [
    "animals": ("pawprint.fill","animals", ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"]),
    "faces": ("face.smiling.fill","faces", ["🤭", "😄", "😁", "😆", "😅", "😂", "🤣"]),
    "vehicles": ("car.fill","vehicles", ["🚕", "🚍", "🚜", "🏎️", "🚑", "🚓"])
]

struct ContentView: View {
    @State var currentButton:String="animals"
    var body: some View {
        
        VStack{
            Text("Memorize!").font(.largeTitle).fontWeight(.semibold)
            ScrollView{
                cards
            }
            buttons
        }
    }
    var cards:some View {
        let list=(themes[currentButton]?.emojis ?? []).shuffled()
     return LazyVGrid(columns: [GridItem(.adaptive(minimum:120))] ){
            ForEach(0..<list.count,id:\.self){ index in
                Card(isFaceUp:false, content:list[index]).padding()
                    .aspectRatio(2/3,contentMode: .fit )
            }
        }.foregroundStyle(.red)
    }
    func EmojiesButton( by title:String,image:String,isCheck:Bool)->some View {
        Button(action:{
            currentButton=title
        }, label:{
            VStack{
                Image(systemName: image).font(.largeTitle)
                Text(title)
            }.foregroundStyle(isCheck ? .red  : .blue)
        } ).padding()
    }
    var buttons:some View{
        HStack(){
            let keys = Array(themes.keys)
            ForEach(0..<themes.count,id:\.self){ index in
                let key=keys[index]
                EmojiesButton(by:themes[key]?.title ?? "", image:themes[key]?.image ?? "",isCheck:currentButton==key)
            }

        }
    }
}




struct Card:View{
    @State var isFaceUp:Bool
    let content:String
    var body : some View{
        let base=RoundedRectangle(cornerRadius: 12)
        ZStack{
            Group{
                base.fill(Color.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
