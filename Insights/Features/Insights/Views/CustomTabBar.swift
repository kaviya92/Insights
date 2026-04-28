import SwiftUI

struct CustomTabBar: View {
    var body: some View {
        VStack {
            Divider()
            HStack {
                Spacer()
                TabBarButton(iconName: "house.fill", label: "Home")
                Spacer()
                TabBarButton(iconName: "target", label: "Track")
                Spacer()
                TabBarButton(iconName: "chart.bar.fill", label: "Insights")
                Spacer()
                AddButton()
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.white)
        }
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
    }
}

struct TabBarButton: View {
    let iconName: String
    let label: String
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.title2)
            Text(label)
                .font(.caption2)
        }
        .foregroundColor(label == "Insights" ? Color.purple : Color.gray)
    }
}

struct AddButton: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.purple)
                .frame(width: 50, height: 50)
            Image(systemName: "plus")
                .font(.title2)
                .foregroundColor(.white)
        }
        .offset(y: -10)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
            .previewLayout(.sizeThatFits)
    }
}