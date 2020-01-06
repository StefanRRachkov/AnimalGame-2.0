-- Animal Game 2.0
-- First Entries : a Dog, a Cat, a Parrot, a Golden Fish

data Node = Node{
    question :: String,
    yes :: Node,
    no :: Node
} | Animal{
    animalName :: String
} deriving (Show, Read, Eq, Ord)

isItACat = Animal "a Cat"
isItADog = Animal "a Dog"
isItAParrot = Animal "a Parrot"
isItAGoldenFish = Animal "a Golden Fish"

isItHyperActive = Node "Is it hyper-active (Y/N)" isItADog isItACat
canItFly = Node "Can it fly (Y/N)" isItAParrot isItHyperActive
firstQuestion = Node "Can it swim (Y/N)" isItAGoldenFish canItFly

getPlayerInput :: String -> IO Bool
getPlayerInput quest = do
        putStrLn quest
        let waitForPlayerResponse = do
                playerInput <- getLine
                case playerInput of
                    "Y" -> return True
                    "N" -> return False
                    _ -> waitForPlayerResponse
        waitForPlayerResponse

addNode :: String -> IO Node 
addNode currentAnimal = do
        putStrLn "I concede to your power! What is the answer?"
        newAnimal <- getLine
        putStrLn $ "How can I distinguish " ++ currentAnimal ++ " from " ++ newAnimal
        distQuestion <- getLine
        lrNode <- getPlayerInput $ "For " ++ newAnimal ++ ", what is the answer? (Y/N)"
        putStrLn "Thank you, It is Saved"
        let (l, r) = if lrNode then (newAnimal, currentAnimal) else (currentAnimal, newAnimal)
        return $ Node {question = distQuestion, yes = (Animal l), no = (Animal r)}

getNode :: Node -> IO Node
getNode n@Node{} = do
        inp <- getPlayerInput $ question n
        nextQuestion <- getNode $ if inp then yes n else no n
        return $ if inp then n {yes = nextQuestion} else n {no = nextQuestion}

getNode (Animal finalState) = do 
            inp <- getPlayerInput $ "Is it " ++ finalState ++ "? (Y/N)"
            if inp then do
                        putStrLn "I guessed it!"
                        return (Animal finalState)
                   else
                        addNode finalState
                    


gameLoop startQuestion = do
    playerInput <- getNode startQuestion
    restart <- getPlayerInput "Play again? (Y/N)"
    if restart
        then gameLoop playerInput
        else return playerInput

main = do
    putStrLn "For every question answer with a capital Y - Yes or N - No"
    gameLoop firstQuestion