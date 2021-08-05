import SwiftUI

struct CartItemView: View {
    var body: some View {
        HStack {
            HStack(spacing: 10) {
                VStack(alignment: .leading) { 
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {

                        Image(systemName: "photo.fill.on.rectangle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 107, height: 57)

                    }
                    .padding(.leading, 10)
                    Text("ITEM NAME")
                        .detailFont()
                        .padding(.leading)
                }

            }
            Spacer()

            VStack(alignment: .trailing, spacing: 0) {
                Text("₱999.99")
                    .largeTitleFont()
                    .offset(y: 5)
                Spacer()
                Text("QTY: x1")
                    .foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
                    .detailFont()

            }.padding(.trailing, 10)

        }.offset(x: 0)

    }
}

struct CartItemView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemView()
            .previewLayout(.fixed(width: 475, height: 100))
    }
}
