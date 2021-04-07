//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Krzysztof Kostrzewa on 06.04.21.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false

    @State private var sort: SortType = .none
    @State private var isShowingSortSelector = false

    let filter: FilterType

    private var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }

    private var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }

    private var sortedProspects: [Prospect] {
        if sort == .alphabetical {
            return filteredProspects.sorted { $0.name <= $1.name }
        }
        return filteredProspects
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(sortedProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if filter == .none {
                            Image(systemName: prospect.isContacted ? "checkmark.circle.fill" : "questionmark.circle.fill")
                                .imageScale(.large)
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            prospects.toggle(prospect)
                        }

                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }

            .navigationBarTitle(title)
            .navigationBarItems(leading:
                Label("Sort", systemImage: "arrow.up.arrow.down.square")
                    .contextMenu {
                        Button("None") { sort = .none }
                        Button("Alpabetical") { sort = .alphabetical }
                    },
                trailing: Button(action: {
                    isShowingScanner.toggle()
                }) {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                })

            .sheet(isPresented: $isShowingScanner, content: {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Test\ntest@test.test", completion: handleScan)
            })
        }
    }

    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        isShowingScanner = false

        switch result {
        case let .success(code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect()
            person.name = details.first!
            person.emailAddress = details.last!

            prospects.add(person)

        case let .failure(error):
            print("Scanning failed \(error.localizedDescription)")
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = .default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }

    enum FilterType {
        case none, contacted, uncontacted
    }

    enum SortType {
        case none, alphabetical
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
