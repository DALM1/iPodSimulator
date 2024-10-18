import SwiftUI

struct ContentView: View {
    @State private var selectedMenuItem = 0
    let menuItems = ["Playlists", "Extras", "Settings", "Shuffle Songs", "Backlight"]

    @State private var rotation: Angle = .zero

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    Color(red: 0.85, green: 0.85, blue: 0.85)
                    VStack {
                        Text("iPod")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.top, 10)

                        Spacer()

                        VStack {
                            ForEach(menuItems.indices, id: \.self) { index in
                                HStack {
                                    Text(menuItems[index])
                                        .foregroundColor(index == selectedMenuItem ? .white : .black)
                                        .font(.system(size: 20, weight: .medium))
                                        .padding(.leading, 20)

                                    Spacer()

                                    if index == selectedMenuItem {
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.white)
                                            .padding(.trailing, 20)
                                    }
                                }
                                .frame(height: 40)
                                .background(index == selectedMenuItem ? Color.blue : Color.clear)
                            }
                        }
                        .frame(height: geometry.size.height * 0.4)
                    }
                    .padding()
                }
                .frame(height: geometry.size.height * 0.6)
                .cornerRadius(10)

                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: geometry.size.width * 0.75, height: geometry.size.width * 0.75)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                        )
                        .shadow(radius: 2)
                        .gesture(
                            RotationGesture()
                                .onChanged { angle in
                                    handleRotationChange(angle: angle)
                                }
                        )

                    Text("MENU")
                        .font(.headline)
                        .offset(y: -geometry.size.width * 0.25)

                    Button(action: {
                    }) {
                        Image(systemName: "backward.fill")
                            .font(.system(size: 30))
                    }
                    .offset(x: -geometry.size.width * 0.25)

                    Button(action: {
                    }) {
                        Image(systemName: "playpause.fill")
                            .font(.system(size: 30))
                    }
                    .offset(y: geometry.size.width * 0.25)

                    Button(action: {
                    }) {
                        Image(systemName: "forward.fill")
                            .font(.system(size: 30))
                    }
                    .offset(x: geometry.size.width * 0.25)
                }
                .frame(height: geometry.size.height * 0.4)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
        }
    }

    func handleRotationChange(angle: Angle) {
        if angle.degrees > rotation.degrees + 15 {
            rotation = angle
            selectedMenuItem = (selectedMenuItem + 1) % menuItems.count
        } else if angle.degrees < rotation.degrees - 15 {
            rotation = angle
            selectedMenuItem = (selectedMenuItem - 1 + menuItems.count) % menuItems.count
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
