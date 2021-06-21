//
//  ContentView.swift
//  BowlNow!
//
//  Created by Kyle Cermak on 1/24/21.
//

import SwiftUI
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import AuthenticationServices

enum ModalView {
    case forgotPassword
    case signUp
}


struct Login: View {
    
    //Create variables on view creation
    
    @Environment(\.colorScheme) var colorScheme
    var request = UserRequests()
    var globalRequests = GlobalRequests()
    var centerUserRequests = CenterUserRequests()
    @State var email: String = UserDefaults.standard.string(forKey: "storeEmail") ?? ""
    @State var password: String = UserDefaults.standard.string(forKey: "storePassword") ?? ""
    @State private var remember: Bool = true
    @State private var showingAlert: Bool = false
    @State private var showModal = false
    @State private var isUserLogged: Bool = false
    @State private var isAdminLogged: Bool = false
    @State private var isActive: Bool = false
    @State private var message: String = ""
    @State private var title: String = ""
    @State private var didLoadData: Bool = false
    @State private var counter: Int = 0
    @State private var ActiveCenters: [CenterObject] = []
    @State var MyCenterData: [UserObject] = []
    @State private var TestData: [UserObject] = []
    @State private var modalView: ModalView?
    
    //Main View
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    Image("Ball_Return")
                        .resizable()
                        .aspectRatio(geometry.size, contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    RoundedRectangle(cornerRadius: 10)
                        .edgesIgnoringSafeArea(.all)
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width, height: geometry.size.height/3, alignment: .bottom)
                        VStack {
                            Logo()
                            NavigationLink(destination: GlobalAdminHome(ActiveCenters: $ActiveCenters), isActive: $isAdminLogged) { EmptyView() }
                            /*NavigationLink(destination: CenterAdminHome(), isActive: $isUserLogged) { EmptyView() }*/
                            NavigationLink(destination: MyCenters(ActiveCenters: $ActiveCenters, rootIsActive: $isUserLogged), isActive: $isUserLogged) { EmptyView() }
                        VStack {
                            EmailField(email: $email)
                            PasswordField(password: $password)
                            HStack {
                                ToggleButton(remember: $remember)
                                Spacer()
                                Button(action: {
                                    CheckFields()
                                }){
                                    Text("Sign In").foregroundColor(.white).bold()
                                }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                                .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
                                .cornerRadius(10)
                                .padding([.horizontal,.bottom])
                            }.padding(.top)
                        }.background(Color(.white))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(radius: 3)
                        VStack {
                            FacebookAppleButtons()
                        }
                        BottomButtons()
                    }
                }.navigationBarTitle("Login")
                .navigationBarHidden(true)
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text((title)), message: Text((message)), dismissButton: .default(Text("OK")))
            }.onAppear(perform:  {
                print(didLoadData)
                if didLoadData == false {
                    CheckToken()
                }
            })
        }
    }
    
    //Function for checking auth token
    
    /*Check if cache is not empty of authtoken. If not empty make a variable from cached token and send it to authentication request.
     If auth request = 200 call function to retrieve all active centers while passing user type to function. If request does not = 200
     display alert in UI for acknowledgement.*/
    
    func CheckToken() {
            if UserDefaults.standard.string(forKey: "AuthToken") != nil {
            let AuthToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
            request.VerifyAuth(authToken: AuthToken) {(success, message) in
                if success == true && message == "User" {
                    GetActiveCenters(Type: "User")
                }
                else if success == true && message == "Admin" {
                    GetActiveCenters(Type: "Admin")
                }
                else {
                    self.title = "Login Failed!"
                    self.message = message
                    self.showingAlert.toggle()
                }
            }
        }
    }
    
    //Function for checking if Ui fields are empty
    
    //Used only when user is not autologged from cached auth token
    /*If empty display alert for UI acknowledgment. If all fields are not empty check if "remember me" box is checked and
     cache the field values. Finally perform a standard login request.*/
    
    func CheckFields() {
        if (self.email.count == 0) {
            self.message = "Email cannot be empty"
            self.showingAlert = true
        }
        else if (self.password.count == 0) {
            self.message = "Password cannot be empty"
            self.showingAlert = true
        }
        else {
            if self.remember {
                SaveData(email: self.email, password: self.password)
            }
            Login()
        }
    }
    
    //function for saving email and password if remember me is checked

    func SaveData(email: String, password: String) {
        UserDefaults.standard.set(email, forKey: "storeEmail")
        UserDefaults.standard.set(password, forKey: "storePassword")
    }
    
    //Function for calling login request
    
    /*Only used when not being auto logged in by existed cached auth token. Send inputted email and password for verification.
     If auth request = 200 call function to retrieve all active centers while passing user type to function. If request does not = 200
     display alert in UI for acknowledgement.*/
    
    func Login() {
        request.LoginRequest(email: self.email, password: self.password) {(success, message) in
            if success == true && message == "User" {
               GetActiveCenters(Type: "User")
            }
            else if success == true && message == "Admin" {
                GetActiveCenters(Type: "Admin")
            }
            else {
                self.title = "Login Failed!"
                self.message = message
                self.showingAlert.toggle()
            }
        }
    }
    
    //Function for calling get active centers request
    
    /*Takes in user type of user or admin. If request to get active centers = 200, user type will determine next called function.
     If regular user type store active centers "pending data" in array and use cached authtoken to retrieve all center user objects. If
     admin type store active centers in array the same way and simply show global admin view. If request does not = 200 display alert in UI for acknowledgement.*/
    
    func GetActiveCenters(Type: String) {
        globalRequests.ActiveCentersList() {(success, message, pendingData) in
            if success == true && Type == "User" {
                ActiveCenters = pendingData
                let AuthToken: String = UserDefaults.standard.string(forKey: "AuthToken") ?? ""
                GetCenterUsers(AuthToken: AuthToken)
            }
            else if success == true && Type == "Admin" {
                ActiveCenters = pendingData
                self.isAdminLogged.toggle()
            }
            else {
                self.title = "Failed To Load Center Data"
                self.message = message
                self.showingAlert.toggle()
            }
        }
    }
    
    //Function used for getting all center user objects for general user
    
    /*Use current authtoken to retrieve objects. If success loop through all user objects in array calling a request
     to retrieve corresponding points collection for each. Then insert integer point value into user object for each center user
     and append array "MyCenterData" with now updated user objects. Once variable counter = the number of user objects retrieved and updated,
     then we can store the filled MyCenterData in cache after encoding. This array contains all user data for each bowling center they have
     a loyalty program with. After caching set loading variable to complete(true) and move to the my centers view. If any request fails
     here display alert in UI for acknowledgement. */
    
    func GetCenterUsers(AuthToken: String) {
        centerUserRequests.GetCenterUser(AuthToken: AuthToken, CenterMoid: "") {(success, message, userData) in
            if success == true {
                for var user in userData {
                    centerUserRequests.GetLoyaltyPoints(AuthToken: AuthToken, CenterMoid: user.CenterMoid) {(success, message, userPoints) in
                        if success == true {
                            for data in userPoints {
                                user.Points = data.Points
                                let newUserObject = user
                                MyCenterData.append(newUserObject)
                                do {
                                    // Create JSON Encoder
                                    let encoder = JSONEncoder()

                                    // Encode Note
                                    let data = try encoder.encode(MyCenterData)
                                    print("Stored my centers")

                                    // Write/Set Data
                                    UserDefaults.standard.set(data, forKey: "MyCenters")

                                } catch {
                                    print("Unable to Encode Array of Notes (\(error))")
                                }
                                counter+=1
                                if counter == userData.count {
                                    self.didLoadData = true
                                    self.isUserLogged.toggle()
                                }
                            }
                        }
                        else {
                            self.title = "Failed To Load User Points"
                            self.message = message
                            self.showingAlert.toggle()
                        }
                    }
                }
            }
            else {
                self.title = "Failed To Load User Data"
                self.message = message
                self.showingAlert.toggle()
            }
        }
    }
}

//View for bowl now logo

struct Logo: View {
    var body: some View {
        Image("BowlNow_Logo")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 250)
        Spacer()
    }
}

//Text field for email input

struct EmailField: View {
    @Binding var email: String
    var body: some View {
        VStack {
            HStack {
                Image("Bowl_now_pin").resizable().scaledToFit().frame(maxWidth: 10, maxHeight: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.leading)
                TextField("Enter your email", text: $email)
                    .foregroundColor(.black)
                    .padding()
            }
        }.background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding([.horizontal,.top])
    }
}

//Text field for password input

struct PasswordField: View {
    @Binding var password: String
    var body: some View {
        VStack {
            HStack {
                Image("Bowl_now_pin").resizable().scaledToFit().frame(maxWidth: 10, maxHeight: 30, alignment: .center)
                    .padding(.leading)
                TextField("Enter your password", text: $password)
                    .foregroundColor(.black)
                    .padding()
            }
        }.background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

//View for remember me check box
//Toggle checkbox calls function

struct ToggleButton: View {
    @Binding var remember: Bool
    var body: some View {
        Toggle(isOn: $remember) {
            Text("Remember Me").foregroundColor(.gray)
        }.toggleStyle(CheckboxToggleStyle())
        .padding([.leading,.bottom])
    }
}

//View and function for toggling check box on click

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 22, height: 22)
                .foregroundColor(.gray)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

//View for facebook and apple sign-ins
//TODO

struct FacebookAppleButtons: View {
    var body: some View {
        FacebookButton().frame(width: .infinity, height: 40).cornerRadius(10).padding([.horizontal,.top])
        if #available(iOS 14.0, *) {
            VStack {
                SignInWithAppleButton(.signIn,              //1
                     onRequest: { (request) in             //2
                       //Set up request
                     },
                     onCompletion: { (result) in           //3
                       switch result {
                       case .success(let authorization):
                           //Handle autorization
                           break
                       case .failure(let error):
                           //Handle error
                           break
                       }
                     })
           }.signInWithAppleButtonStyle(.black).frame(width: .infinity, height: 40).cornerRadius(10).padding([.horizontal])            //4
        } else {
            // Fallback on earlier versions
        }
    }
}

//View for sign-up, forgot password and privacy buttons
//Bottom of UI

struct BottomButtons: View {
    @State private var showingSignUp = false
    @State private var showingForgotPassword = false
    var body: some View {
        Spacer()
        NavigationLink(destination: SignUp(), isActive: $showingSignUp) { EmptyView()}
        HStack {
            Button(action: {
                self.showingSignUp = true
            }){
                Text("Sign Up").foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            }
            Spacer()
            Divider()
                .frame(maxWidth:2,maxHeight:30)
                .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            Spacer()
            Button(action: {
                self.showingForgotPassword = true
            }){
                Text("Forgot Password?").foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            }.sheet(isPresented: self.$showingForgotPassword) {
                ForgotPassword()
            }
            Spacer()
            Divider()
                .frame(maxWidth:2,maxHeight:30)
                .background(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            Spacer()
            Button(action: {
                let formattedString = "https://chicagolandbowlingservice.com/privacy-policy"
                let url = URL(string: formattedString)!
                UIApplication.shared.open(url)
            }){
                Text("Privacy").foregroundColor(Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))
            }
        }.padding([.horizontal,.bottom])
    }
}

//Function for making Facebook button

struct FacebookButton: UIViewRepresentable {
    
    func makeUIView(context:Context) -> FBLoginButton{
        let button = FBLoginButton()
        return button
    }
    
    func updateUIView(_ uiVIew: FBLoginButton, context: UIViewRepresentableContext<FacebookButton>) {
        
    }
}

//View used to indicate swipe down arrow for closing sheet views

struct SwipeDown: View {
    var body: some View {
        Text("Swipe down to close")
            .font(.subheadline)
        VStack {
            LinearGradient(gradient: Gradient(colors: [.white, (Color(red: 146/255, green: 107/255, blue: 214/255, opacity: 1.0))]), startPoint: .top, endPoint: .bottom)
                    .mask(Image(systemName: "arrow.down")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .padding())
        }.frame(width: 40, height: 40).padding(.bottom)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

