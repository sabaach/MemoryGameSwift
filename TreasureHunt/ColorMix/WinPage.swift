import SwiftUI

struct WinPage: View {
    var body: some View {
        ZStack {
            // Background image
            Image("backgroundBadge") // Ganti "backgroundImage" dengan nama gambar latar belakang dari asset
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            // Image di tengah
            VStack {
                Spacer()
                Image("badge3") // Ganti "centeredImage" dengan nama gambar yang ingin Anda gunakan
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200) // Sesuaikan ukuran gambar sesuai kebutuhan
                Spacer()
            }
        }
    }
}

struct WinPage_Previews: PreviewProvider {
    static var previews: some View {
        WinPage()
    }
}
