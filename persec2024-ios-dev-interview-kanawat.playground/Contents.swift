import Foundation


// ข้อ 1
func isValidParentheses(_ s: String) -> Bool {
    // สร้าง stack เพื่อเก็บสัญลักษณ์ที่เปิด
    var stack = [Character]()
    
    // สร้าง dictionary สำหรับคู่ของสัญลักษณ์
    let matchingParentheses: [Character: Character] = [
        ")": "(",
        "]": "[",
        "}": "{"
    ]
    
    // วนลูปผ่านทุกตัวอักษรใน string
    for char in s {
        if char == "(" || char == "[" || char == "{" {
            // ถ้าเป็นสัญลักษณ์ที่เปิด ให้ใส่ลงใน stack
            stack.append(char)
        } else if char == ")" || char == "]" || char == "}" {
            // ถ้าเป็นสัญลักษณ์ที่ปิด
            if let last = stack.last, last == matchingParentheses[char] {
                // ถ้า stack ไม่ว่างและตัวสุดท้ายใน stack ตรงกับสัญลักษณ์ที่ปิด ให้นำออกจาก stack
                stack.removeLast()
            } else {
                // ถ้าไม่ตรง ให้ return false
                return false
            }
        }
    }
    
    // ตรวจสอบว่า stack ว่างหรือไม่ ถ้าว่าง return true, ถ้าไม่ว่าง return false
    return stack.isEmpty
}

// ตัวอย่างการใช้งาน
print(isValidParentheses("()"))         // true
print(isValidParentheses("([]]"))       // false
print(isValidParentheses("([{}])"))     // true
print(isValidParentheses("([[{}]]]"))   // false
print(isValidParentheses(")"))          // false
print(isValidParentheses("(]}])"))      // false
print(isValidParentheses("([)]"))       // false
print(isValidParentheses("{"))          // false



// ข้อ 2
func customSort(_ array: [String]) -> [String] {
    return array.sorted { (a, b) -> Bool in
        // แยกส่วนที่เป็น prefix (ตัวอักษร) และ suffix (ตัวเลข) ออกจากสตริง
        let prefixA = a.prefix(while: { $0.isLetter })
        let suffixA = a.drop(while: { $0.isLetter })
        
        let prefixB = b.prefix(while: { $0.isLetter })
        let suffixB = b.drop(while: { $0.isLetter })
        
        // ถ้า prefix ไม่เท่ากัน ให้เรียงตาม prefix
        if prefixA != prefixB {
            return prefixA < prefixB
        }
        
        // ถ้า prefix เท่ากัน ให้เรียงตาม suffix
        if let numA = Int(suffixA), let numB = Int(suffixB) {
            return numA < numB
        }
        
        // ถ้า suffix ไม่สามารถเปรียบเทียบเป็นตัวเลขได้ ให้เรียงตามสตริงเดิม
        return suffixA < suffixB
    }
}

// ตัวอย่างการใช้งาน
print(customSort(["TH19", "SG20", "TH2"]))            // ["SG20", "TH2", "TH19"]
print(customSort(["TH10", "TH3Netflix", "TH1", "TH7"])) // ["TH1", "TH3Netflix", "TH7", "TH10"]



// ข้อ 3
func autocomplete(search: String, items: [String], maxResult: Int) -> [String] {
    // แปลง search เป็น lowercase เพื่อ ignore case
    let searchLower = search.lowercased()
    
    // แบ่งกลุ่มคำที่ค้นหาตามเงื่อนไข
    var startsWithSearch: [String] = []
    var containsSearch: [String] = []
    
    for item in items {
        let itemLower = item.lowercased()
        if itemLower.hasPrefix(searchLower) {
            startsWithSearch.append(item)
        } else if itemLower.contains(searchLower) {
            containsSearch.append(item)
        }
    }
    
    // รวมกลุ่มคำที่ค้นหาและจำกัดจำนวนผลลัพธ์ตาม maxResult
    let result = (startsWithSearch + containsSearch).prefix(maxResult)
    
    return Array(result)
}

// ตัวอย่างการใช้งาน
print(autocomplete(search: "th", items: ["Mother", "Think", "Worthy", "Apple", "Android"], maxResult: 3)) // ["Think", "Mother"]
print(autocomplete(search: "an", items: ["Mother", "Think", "Worthy", "Apple", "Android"], maxResult: 5)) // ["Android"]
print(autocomplete(search: "or", items: ["Mother", "Think", "Worthy", "Apple", "Android"], maxResult: 2)) // ["Worthy"]


// ข้อ 4

func intToRoman(_ num: Int) -> String {
    let values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    let symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
    
    var number = num
    var result = ""
    
    for (index, value) in values.enumerated() {
        while number >= value {
            number -= value
            result += symbols[index]
        }
    }
    
    return result
}

// ตัวอย่างการใช้งาน
print(intToRoman(1989))  // "MCMLXXXIX"
print(intToRoman(2000))  // "MM"
print(intToRoman(68))    // "LXVIII"
print(intToRoman(109))   // "CIX"

func romanToInt(_ s: String) -> Int {
    let values: [Character: Int] = [
        "I": 1,
        "V": 5,
        "X": 10,
        "L": 50,
        "C": 100,
        "D": 500,
        "M": 1000
    ]
    
    var result = 0
    var previousValue = 0
    
    for char in s.reversed() {
        let value = values[char] ?? 0
        if value < previousValue {
            result -= value
        } else {
            result += value
        }
        previousValue = value
    }
    
    return result
}

// ตัวอย่างการใช้งาน
print(romanToInt("MCMLXXXIX"))  // 1989
print(romanToInt("MM"))         // 2000
print(romanToInt("LXVIII"))     // 68
print(romanToInt("CIX"))        // 109

// ข้อ 5
func sortDigitsDescending(_ num: Int) -> Int {
    // แปลง Int เป็น String เพื่อให้สามารถแยกตัวเลขได้
    let numStr = String(num)
    
    // แปลง String เป็น Array ของ Character เพื่อทำการเรียงลำดับ
    let sortedChars = numStr.sorted(by: >)
    
    // แปลง Array ของ Character กลับเป็น String
    let sortedStr = String(sortedChars)
    
    // แปลง String กลับเป็น Int
    let sortedInt = Int(sortedStr)!
    
    return sortedInt
}

// ตัวอย่างการใช้งาน
print(sortDigitsDescending(3008))  // 8300
print(sortDigitsDescending(1989))  // 9981
print(sortDigitsDescending(2679))  // 9762
print(sortDigitsDescending(9163))  // 9631

// ข้อ 6

func tribonacci(_ sequence: [Int], _ n: Int) -> [Int] {
    // ถ้าค่าที่ต้องการมีน้อยกว่าหรือเท่ากับจำนวนเริ่มต้น ให้ return ค่านั้นทันที
    if n <= sequence.count {
        return Array(sequence.prefix(n))
    }
    
    // เตรียม array เริ่มต้น
    var result = sequence
    
    // ถ้ามีค่าที่น้อยกว่า 3 ตัว ให้เติม 0 จนกว่าจะครบ 3 ตัว
    while result.count < 3 {
        result.append(0)
    }
    
    // ใช้ลูปเพื่อคำนวณค่าที่ตามมาจนกว่าจะได้จำนวนที่ต้องการ
    while result.count < n {
        let nextValue = result[result.count - 1] + result[result.count - 2] + result[result.count - 3]
        result.append(nextValue)
    }
    
    return result
}

// ตัวอย่างการใช้งาน
print(tribonacci([1, 3, 5], 5))   // [1, 3, 5, 9, 17]
print(tribonacci([2, 2, 2], 3))   // [2, 2, 2]
print(tribonacci([10, 10, 10], 4)) // [10, 10, 10, 30]
print(tribonacci([], 6))           // [0, 0, 0, 0, 0, 0]
print(tribonacci([5], 5))          // [5, 0, 0, 5, 5]
print(tribonacci([1, 2], 6))       // [1, 2, 0, 3, 2, 5]


