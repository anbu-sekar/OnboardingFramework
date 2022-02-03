import SwiftUI

struct OnboardingData: Identifiable {
    var id: String = UUID().uuidString
    
    var image: String
    var title: String?
    var detail: String?
    var bgColor: Color?
    var pageID: Int?
}

public struct OnBoarding: View {
    
    public var totalPages: Int {
        datasource.count
    }
    
    @AppStorage("currentPage") var currentpage = 1
    
    var datasource: [OnboardingData]
    
    private init(screensData: [OnboardingData]) {
        self.datasource = screensData
    }
    
    
    // MARK: - Body
    public var body: some View {
        // For slide animation
        
        ZStack {
            //tab view
            ForEach (self.datasource) { scren in
                if currentpage == scren.pageID {
                    ScreenView(image: scren.image, title: scren.title, detail: scren.detail, bgColor: scren.bgColor)
                }
            }
            
        }
        .overlay(
            HStack {
                Button(action: {
                    withAnimation(.easeOut) {
                        if currentpage < totalPages {
                            currentpage += 1
                        } else {
                            currentpage = 1
                        }
                    }
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 60, height: 60)
                        .background(.white)
                        .clipShape(Circle())
                    
                        .overlay(
                            ZStack {
                                Circle()
                                    .stroke(Color.black.opacity(0.04), lineWidth: 4)
                                
                                Circle()
                                    .trim(from: 0, to: CGFloat(currentpage) / CGFloat(totalPages))
                                    .stroke(.white, lineWidth: 4)
                                    .rotationEffect(.init(degrees: -90))
                                
                            }
                                .padding(-15)
                        )
                    
                    
                })
                Button(action: {
                    withAnimation(.easeOut) {
                        if currentpage < totalPages {
                            currentpage += 1
                        } else {
                            currentpage = 1
                        }
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 60, height: 60)
                        .background(.white)
                        .clipShape(Circle())
                    
                        .overlay(
                            ZStack {
                                Circle()
                                    .stroke(Color.black.opacity(0.04), lineWidth: 4)
                                
                                Circle()
                                    .trim(from: 0, to: CGFloat(currentpage) / CGFloat(totalPages))
                                    .stroke(.white, lineWidth: 4)
                                    .rotationEffect(.init(degrees: -90))
                                
                            }
                                .padding(-15)
                        )
                    
                    
                })
            }
            
                .padding(.bottom, 20)
            ,alignment: .bottom
        )
        
    }
    
    struct ScreenView: View {
        
        var image: String
        var title: String?
        var detail: String?
        var bgColor: Color?
        
        @AppStorage("currentPage") var currentpage = 1
        var body: some View {
            VStack(spacing: 20) {
                HStack {
                    
                    if currentpage == 1 {
                        Text("Helloe Member!!!")
                            .font(.title)
                            .fontWeight(.semibold)
                            .kerning(1.4)
                    } else {
                        Button(action: {
                            withAnimation(.easeOut) {
                                currentpage -= 1
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(Color.black.opacity(0.4))
                                .cornerRadius(10)
                        }
                    }
                    Spacer()
                    Button(action: {
                        currentpage = 5
                    }) {
                        Text("Skip")
                            .fontWeight(.semibold)
                            .kerning(1.3)
                        
                    }
                    
                }
                .foregroundColor(.black)
                .padding()
                
                Spacer(minLength: 0)
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(title ?? "")
                    . font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top)
                
                Text("It is a long established fact that a reader will be distracted")
                    .fontWeight(.semibold)
                    .kerning(1.3)
                    .multilineTextAlignment(.center)
                
                
                Spacer(minLength: 120)
            }
            .background(bgColor.cornerRadius(10).ignoresSafeArea())
        }
    }
}
