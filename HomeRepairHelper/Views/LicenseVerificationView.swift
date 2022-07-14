//
//  LicenseVerificationView.swift
//  HomeRepairHelper
//
//  Created by robevans on 7/13/22.
//
import BetterSafariView
import SDWebImageSwiftUI
import SwiftUI

struct LicenseVerificationView: View {
    @Environment(\.openURL) private var openURL

    @State var showSafari: Bool = false
    @State var indexValue: Int = 0
    @State var selectedItem: StateData
    @StateObject var telemtryData = TelemetryData()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section() {
                        Text("You should always confirm that a contractor has a valid license prior start a project. You can check your local state and confirm their license status.")
                    }
                    Section(header: Text("State")) {
                        ForEach(stateData.sorted(by: { $0.state < $1.state
                        })) { state in
                            Button(action: {
                                playHaptic(style: "medium")
                                selectedItem = state
                                telemtryData.sendLicVerifyState(state: state.state)
                                withAnimation {
                                    indexValue = state.id
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        showSafari = true
                                    }
                                }
                            })
                            {
                                StateRowView(state: state, index: state.id, showSafari: $showSafari)
                            }
                        }
                    }
                }
                .safariView(isPresented: $showSafari) {
                    SafariView(
                        url: URL(string: selectedItem.stateURL)!,
                        configuration: SafariView.Configuration(
                            entersReaderIfAvailable: false,
                            barCollapsingEnabled: true
                        )
                    )
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("License Verification")
        }
    }
}

struct StateRowView: View {

    let state: StateData
    let index: Int
    @Binding var showSafari: Bool

    var body: some View {
        HStack {
            WebImage(url: URL(string: "https://cdn.civil.services/us-states/flags/\(state.stateCode)-small.png"))
                .resizable()
                .placeholder(Image(systemName: "flag.circle"))
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .shadow(radius: 2)
            Text(state.state)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

struct StateData: Identifiable {
    let id: Int
    var state: String
    var stateURL: String
    var stateCode: String
}
// https://github.com/CivilServiceUSA/us-states
var stateData = [
    StateData(id: 0, state: "Washington State", stateURL: "https://secure.lni.wa.gov/verify", stateCode: "washington"),
    StateData(id: 1, state: "Alaska", stateURL: "https://www.commerce.alaska.gov/web/cbpl/ProfessionalLicensing/ProfessionalLicenseSearch.aspx", stateCode: "alaska"),
    StateData(id: 2, state: "Georgia", stateURL: "https://verify.sos.ga.gov/verification/", stateCode: "georgia"),
    StateData(id: 3, state: "South Carolina", stateURL: "https://verify.llronline.com/LicLookup/LookupMain.aspx", stateCode: "south-carolina"),
    StateData(id: 4, state: "Virginia", stateURL: "https://dhp.virginiainteractive.org/lookup/index", stateCode: "virginia"),
    StateData(id: 5, state: "Indiana", stateURL: "https://www.in.gov/pla/license/free-search-and-verify", stateCode: "indiana"),
    StateData(id: 6, state: "Tennessee", stateURL: "https://verify.tn.gov/", stateCode: "tennessee"),
    StateData(id: 7, state: "Florida", stateURL: "https://mqa-internet.doh.state.fl.us/MQASearchServices/HealthCareProviders", stateCode: "florida"),
    StateData(id: 8, state: "Maine", stateURL: "https://www.pfr.maine.gov/almsonline/almsquery/searchindividual.aspx", stateCode: "maine"),
    StateData(id: 9, state: "Arizona", stateURL: "https://btr.az.gov/public/registered-professional-search", stateCode: "arizona"),
    StateData(id: 10, state: "New York State", stateURL: "https://www.op.nysed.gov/opsearches.htm", stateCode: "new-york"),
    StateData(id: 11, state: "Michigan", stateURL: "https://www.lara.michigan.gov/colaLicVerify/", stateCode: "michigan"),
    StateData(id: 12, state: "Hawaii", stateURL: "https://mypvl.dcca.hawaii.gov/public-license-search/", stateCode: "hawaii"),
    StateData(id: 13, state: "Mississippi", stateURL: "https://msdh.ms.gov/msdhsite/_static/30,0,82,353.html", stateCode: ""),
    StateData(id: 14, state: "Iowa", stateURL: "https://iowaplb.force.com/LicenseSearchPage",stateCode: "iowa"),
    StateData(id: 16, state: "California", stateURL: "https://www.cslb.ca.gov/onlineservices/checklicenseII/checklicense.aspx", stateCode: "california"),
    StateData(id: 15, state: "Idaho", stateURL: "https://dopl.idaho.gov", stateCode: "idaho"),
    StateData(id: 17, state: "Delaware", stateURL: "https://delpros.delaware.gov/OH_VerifyLicense", stateCode: "delaware"),
    StateData(id: 18, state: "Kentucky", stateURL: "https://oop.ky.gov", stateCode: "kentucky"),
    StateData(id: 19, state: "Alabama", stateURL: "https://genconbd.alabama.gov/DATABASE-SQL/roster.aspx", stateCode: "alabama"),
    StateData(id: 20, state: "Arkansas", stateURL: "http://aclb2.arkansas.gov/clbsearch.php", stateCode: "arkansas"),
    StateData(id: 21, state: "Colorado", stateURL: "https://apps.colorado.gov/dora/licensing/Lookup/LicenseLookup.aspx", stateCode: "colorado"),
    StateData(id: 22, state: "Connecticut", stateURL: "https://www.elicense.ct.gov/Lookup/LicenseLookup.aspx", stateCode: "connecticut"),
    StateData(id: 23, state: "Kansas", stateURL: "https://licensing.ks.gov/Verification_KBTP_213/", stateCode: "kansas"),
    StateData(id: 24, state: "Louisiana", stateURL: "https://lslbc.louisiana.gov/contractor-search/", stateCode: "louisiana"),
    StateData(id: 25, state: "Massachusetts", stateURL: "https://www.mass.gov/how-to/check-a-home-improvement-contractor-registration", stateCode: "massachusetts"),
    StateData(id: 26, state: "Minnesota", stateURL: "https://secure.doli.state.mn.us/lookup/licensing.aspx", stateCode: "minnesota"),
    StateData(id: 27, state: "Missouri", stateURL: "https://pr.mo.gov/licensee-search.asp", stateCode: "missouri"),
    StateData(id: 28, state: "Montana", stateURL: "https://erdcontractors.mt.gov/ICCROnlineSearch/registrationlookup.jsp", stateCode: "montana"),
    StateData(id: 29, state: "Nebraska", stateURL: "https://dol.nebraska.gov/conreg/Search", stateCode: "nebraska"),
    StateData(id: 30, state: "Nevada", stateURL: "https://app.nvcontractorsboard.com/Clients/NVSCB/Public/ContractorLicenseSearch/ContractorLicenseSearch.aspx", stateCode: "nevada"),
    StateData(id: 31, state: "New Hampshire", stateURL: "https://forms.nh.gov/licenseverificationtest/", stateCode: "new-hampshire"),
    StateData(id: 32, state: "New Jersey", stateURL: "https://newjersey.mylicense.com/verification/Search.aspx?facility=Y", stateCode: "new-jersey"),
    StateData(id: 33, state: "New Mexico", stateURL: "https://www.rld.nm.gov/about-us/public-information-hub/consumer-protection/verify-a-license/", stateCode: "new-mexico"),
    StateData(id: 34, state: "North Carolina", stateURL: "https://nclbgc.org/license-search/", stateCode: "north-carolina"),
    StateData(id: 35, state: "North Dakota", stateURL: "https://firststop.sos.nd.gov/search/contractor", stateCode: "north-dakota"),
    StateData(id: 36, state: "Ohio", stateURL: "https://elicense4.com.ohio.gov/Lookup/LicenseLookup.aspx", stateCode: "ohio"),
    StateData(id: 37, state: "Oklahoma", stateURL: "http://cibverify.ok.gov/clients/okcib/public/licenseesearch/licenseesearch.aspx", stateCode: "oklahoma"),
    StateData(id: 38, state: "Oregon", stateURL: "https://www.oregon.gov/ccb/Pages/index.aspx", stateCode: "oregon"),
    StateData(id: 39, state: "Pennsylvania", stateURL: "https://hicsearch.attorneygeneral.gov/", stateCode: "pennsylvania"),
    StateData(id: 40, state: "Rhode Island", stateURL: "https://crb.ri.gov/search/contractor-search", stateCode: "rhode-island"),
    StateData(id: 41, state: "South Dakota", stateURL: "https://apps.sd.gov/ld17btp/licenseelist.aspx", stateCode: "south-dakota"),
    StateData(id: 42, state: "Texas", stateURL: "https://www.tdlr.texas.gov/verify.htm", stateCode: "texas"),
    StateData(id: 43, state: "Utah", stateURL: "https://secure.utah.gov/llv/search/index.html", stateCode: "utah"),
    StateData(id: 44, state: "Vermont", stateURL: "https://sos.vermont.gov/opr/find-a-professional/", stateCode: "vermont"),
    StateData(id: 45, state: "West Virginia", stateURL: "https://labor.wv.gov/Licensing/Contractor_License/Pages/contractor-search.aspx", stateCode: "west-virginia"),
    StateData(id: 46, state: "Wisconsin", stateURL: "https://licensesearch.wi.gov/", stateCode: "wisconsin"),
    StateData(id: 47, state: "Wyoming", stateURL: "https://wyoming.licensesearch.org/", stateCode: "wyoming"),
    StateData(id: 48, state: "Illinois", stateURL: "https://online-dfpr.micropact.com/lookup/licenselookup.aspx", stateCode: "illinois"),
    StateData(id: 49, state: "Maryland", stateURL: "https://www.dllr.state.md.us/cgi-bin/ElectronicLicensing/OP_search/OP_search.cgi?calling_app=HIC::HIC_qselect", stateCode: "maryland")
]


struct LicenseVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseVerificationView(selectedItem: StateData(id: 3, state: "South Carolina", stateURL: "https://verify.llronline.com/LicLookup/LookupMain.aspx", stateCode: "south-carolina"))
    }
}
