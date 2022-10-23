protocol IChecker {
    func checkNumber(number: Int)  -> Bool
}

protocol IPublisher{
    func addListener(listener: IChecker)
}


class Player: IChecker {
    var maxNumber: Int
    var name: String
    var cardSize: Int
    var card: Array<Int>

    init(cardSize: Int = 5, name: String, maxNumber: Int = 90){
        self.cardSize = cardSize
        self.name = name
        self.maxNumber = maxNumber
        self.card = Array<Int>()
        getRandomNumbers()
    }

    func checkNumber(number: Int) -> Bool {
        if (self.card.count > 0) {
            if let index = self.card.firstIndex(of: number) {
                self.card.remove(at: index)
            }
            return false
        }
        else{
            notify()
            return true
        }
    }
    
    
    func notify(){
        print(name + "win")
    }

    func getRandomNumbers(){
        while self.card.count < self.cardSize {

            self.card.insert(Int.random(in: 1...100), at: 0)
        }
    }
}


class Publisher: IPublisher {
    var sizeCard: Int
    var numbers: Array<Int>
    var players: Array<IChecker>

    init(sizeCard: Int = 90){
        self.players = Array<IChecker>()
        self.sizeCard = sizeCard
        let n = Array(0...self.sizeCard)
        self.numbers = (n as Array).shuffled() as! [Int]
    }

    func StartGame() {
        var isExit = false
        while(isExit == false && self.numbers.count > 0){
            print(self.numbers)
            let newNumber = self.numbers.removeLast()
            print(newNumber)
            for player in players{
                if(player.checkNumber(number: newNumber)){
                    print("Player win!")
                    isExit = true
                    break
                }
            }
        }
        if (self.numbers.count == 0){
            print("Game is over!!!")
        }
    }

    func addListener(listener: IChecker){
        self.players.insert(listener, at: 0)
    }
}


func main(){
    let player1: Player = Player(name: "firstPlayer")
    let player2: Player = Player(name: "secondPlayer")
    print(player1.card)
    print(player2.card)


    let publisher = Publisher()
    publisher.addListener(listener: player1)
    publisher.addListener(listener: player2)

    publisher.StartGame()
    
}

main()