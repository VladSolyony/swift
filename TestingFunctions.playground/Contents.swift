import UIKit

class BingoSheet {
    
    class BingoBox: CustomStringConvertible {
        
        var label = ""
        var checked = false
        var description: String { return self.label }
        
        init() {
         
            self.label = "blank"
            
        }
        
        init(_ label:String) {
            
            self.label = label
            
        }
        
        init(_ label:String, _ checked:Bool) {
            
            self.label = label
            self.checked = checked
            
        }
        
        func switchCheck() -> Bool{
            
            self.checked = !self.checked
            self.relabel(String(self.checked))
            return self.checked
            
        }
        
        func check() -> Bool {
            
            return self.checked
            
        }
        
        func relabel(_ label:String) {
            
            self.label = label
            
        }
        
    }
    
    var name:String = ""
    var sheet = [[BingoBox]]()
    
    init(_ name:String) {
        
        self.name = name
        
        for i in 0...4 {
            var row = [BingoBox]()
            for j in 0...4 {
                if (i == 2 && j == 2) {
                    row += [BingoBox("Free Space", true)]
                } else {
                    row += [BingoBox()]
                }
            }
            self.sheet += [row]
        }
        
    }
    
    func printSheet() {
        
        print(self.name + "'s Bingo Sheet:")
        for i in 0...4 {
            print(self.sheet[i][0], self.sheet[i][1], self.sheet[i][2], self.sheet[i][3], self.sheet[i][4], separator:"\t")
        }
        
    }
    
    func changeBox(_ i:Int, _ j:Int) {
        
        self.sheet[i][j].switchCheck()
        if (self.checkBingo()) {
            print(self.name + " got a bingo!")
        }
        
    }
    
    func relabelBox(_ i:Int, _ j:Int, _ label:String) {
        
        self.sheet[i][j].relabel(label)
        
    }
    
    func checkBingo() -> Bool {
        
        return (self.checkHorizontal() || self.checkVertical() || self.checkDiagonal())
        
    }
    
    func checkHorizontal() -> Bool {
        
        for row in 0...4 {
            if (self.sheet[row][0].check() && self.sheet[row][1].check() && self.sheet[row][2].check() && self.sheet[row][3].check() && self.sheet[row][4].check()) {
                return true
            }
        }
        return false
        
    }
    
    func checkVertical() -> Bool {
        
        for col in 0...4 {
            if (self.sheet[0][col].check() && self.sheet[1][col].check() && self.sheet[2][col].check() && self.sheet[3][col].check() && self.sheet[4][col].check()) {
                return true
            }
        }
        return false
        
    }
    
    func checkDiagonal() -> Bool {
        
        return ((self.sheet[0][0].check() && self.sheet[1][1].check() && self.sheet[2][2].check() && self.sheet[3][3].check() && self.sheet[4][4].check()) || (self.sheet[0][4].check() && self.sheet[1][3].check() && self.sheet[2][2].check() && self.sheet[3][1].check() && self.sheet[4][0].check()))
        
    }
    
}

var bb1 = BingoSheet("Brian")
print(bb1.name)
bb1.printSheet()
bb1.changeBox(1, 3)
//bb1.changeBox(2, 2)
bb1.changeBox(3, 1)
bb1.changeBox(0, 4)
bb1.changeBox(4, 0)
bb1.printSheet()
bb1.relabelBox(0, 0, "duck")
bb1.printSheet()
