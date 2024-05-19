import SwiftUI

struct ContentView: View {
    @State private var currentDate: String = ""
    @State private var currentTime: String = ""
    @State private var nextPrayerTime: String = "Loading..."
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Current Date: \(currentDate)")
                .font(.title)
                .padding()
            Text("Current Time: \(currentTime)")
                .font(.largeTitle)
                .padding()
            Text(nextPrayerTime)
                .font(.title)
                .padding()
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func startTimer() {
        // Update the time immediately when the view appears
        updateTime()
        // Schedule the timer to update the time every second
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateTime()
        }
    }
    
    private func updateTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        currentDate = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "HH:mm:ss"
        currentTime = dateFormatter.string(from: Date())
        
        let currentDateTime = Date()
        if let prayerTimes = loadPrayerTimes(for: currentDateTime) {
            nextPrayerTime = getNextPrayerTime(currentTime: currentDateTime, prayerTimes: prayerTimes)
        } else {
            nextPrayerTime = "Error loading prayer times"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
