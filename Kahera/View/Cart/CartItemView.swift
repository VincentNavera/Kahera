import SwiftUI

struct CartItemView: View {

    @ObservedObject var cart: CartItems
    let cartItemPrice: Double
    let cartItemName: String
    let cartItemQuantity: Int
    @State private var oldValue = 0
    @State private var newValue = 0

    @State var changeInQuantity: Int {
        didSet {
            newValue = changeInQuantity
        }
        willSet{
            oldValue = changeInQuantity
        }
    }

    @State private var quantityStepper = 0
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
                    .padding(.leading, 1)
                    Text(cartItemName)
                        .detailFont()
                        .padding(.leading)
                }

            }
            Spacer()

            VStack(alignment: .trailing, spacing: 0) {
                Stepper(value: $quantityStepper.onChange(changeInTotalPrice)) {

                }
                .scaleEffect(0.7)
                .offset(x: 45, y: -3)

                Text("₱\(Double(cartItemPrice) , specifier: "%.2f")")
                    .largeTitleFont()

                    .padding(.trailing, 10)
                Text("Quantity: x\(changeInQuantity)")
                    .foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
                    .detailFont()
                    .padding(.trailing, 10)
                Spacer()


            }

        }.offset(x: 0)

    }
    func changeInTotalPrice(_ value: Int) {
        changeInQuantity = cartItemQuantity + quantityStepper
        if newValue > oldValue {
            self.cart.totalPrice += cartItemPrice
        } else {
            self.cart.totalPrice -= cartItemPrice
        }
        print(oldValue, newValue)



    }
}

struct CartItemView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemView(cart: CartItems(), cartItemPrice: 999.99, cartItemName: "Item Name", cartItemQuantity: 1, changeInQuantity: 1)
            .previewLayout(.fixed(width: 475, height: 100))
    }
}
