//
//  Debouncer.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-03.
//

import Foundation

class Debouncer {
    let delay: Double
    var timer: Timer?

    init(delay: Double) {
        self.delay = delay
    }

    func debounce(task: @escaping (() -> Void)) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            task()
        }
    }
}
