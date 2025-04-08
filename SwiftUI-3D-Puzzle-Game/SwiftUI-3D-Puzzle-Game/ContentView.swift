import SwiftUI
import SceneKit

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack{
                VStack (spacing: 60){
                    // Game Title
                    Text("3D Puzzle Game")
                    .font(.largeTitle)
                    .bold()
                    .navigationBarTitleDisplayMode(.inline)
                    .padding([.top, .bottom], 100)
                    
                    Button("Play"){
                        
                    }
                    .frame(width: 60)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 15)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    
                    Button("Setting"){
                        
                    }
                    .frame(width: 60)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 15)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    Spacer()
                }
            }
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color.red.opacity(0.6))
        }
    }
}

#Preview {
    ContentView()
}
