//
//  ContentView.swift
//  ToyCustomPopup
//
//  Created by Faiz Mokhtar AD0502 on 27/12/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var isHidden: Bool = true
    
    var body: some View {
        ZStack {
            Button("Tap Me!") {
                withAnimation {
                    isHidden.toggle()
                }
            }
            if isHidden{
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeIn(duration: 0.1))
                PermissionsPopupView(isHidden: $isHidden)
                    .animation(.easeOut(duration: 0.2))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PermissionsPopupView: View {
    @Binding var isHidden: Bool

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 8.0) {
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("Permissions Request".uppercased())
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(Color.secondary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    Text("Need Permission")
                        .font(.title)
                        .fontWeight(.heavy)
                }
                Spacer()
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color.secondary)
                    .onTapGesture {
                        isHidden.toggle()
                    }
            }
            PermissionView(iconImage: Image(systemName: "location.fill"), title: "Current Location", description: "Needed to provide the most accurate data", buttonAction: {}, showDivider: true)
            PermissionView(iconImage: Image(systemName: "calendar"), title: "Calendar", description: "Needed to show related events on app", buttonAction: {}, showDivider: true)
            PermissionView(iconImage: Image(systemName: "photo.fill"), title: "Photo Library", description: "Needed to save related images in post", buttonAction: {}, showDivider: false)
                .padding(.bottom, 10)
            Text("The following permissions are necessary for the app to work properly . Promise we wouldn't use it outside of its use")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(Color.secondary)
        }
        .padding(20)
        .padding(.vertical, 8)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(20)
    }
}

struct PermissionView: View {
    
    var iconImage: Image
    var title: String
    var description: String
    var buttonAction: (() -> Void)
    var showDivider: Bool = false

    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 4) {
                iconImage
                    .font(.system(size: 28))
                    .foregroundColor(.accentColor)
                    .frame(width: 28, height: 28, alignment: .center)
                    .padding(.trailing, 8)
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.title3)
                        .bold()
                    Text(description)
                        .font(.system(size: 15))
                        .foregroundColor(Color.secondary)
                        .frame(height: 48, alignment: .top)
                }
                Spacer()
                Button(action: buttonAction, label: {
                    Text("ALLOW")
                        .font(.system(size: 14, weight: .bold))
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background(Color(#colorLiteral(red: 0.9318081737, green: 0.9319422841, blue: 0.9386354089, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                })
            }
            if showDivider {
                Divider()
            }
        }
    }
}
