function prob = getLogiHitP(runTotal,runDeck,probD,soft)
%This probability function determines the probabilities that the player
%gets a 17,18,19,20,21, or busts using the optimum strategy of only hitting
%when the odds of winning while hitting are greater than the odds of
%winning while standing.

prob = zeros(1,6);
simDeck = runDeck;
for i=2:11%go through all card values
    if(simDeck.availableCards(i-1) == 0)
        continue;%goes to next card value if deck does not have the current value
    end
    tempSum = runTotal + i;
    if(i==11 && tempSum > 21)
        tempSum = tempSum - 10;%reduces tempSum if adding an ace causes a bust
    elseif(i==11)
        soft = soft + 1;%change soft flag is adding an ace does not cause a bust
    end
    probP = getPlayerP(tempSum,simDeck,soft);
    %probability of player getting [17,18,19,20,21,bust]
    probN = zeros(1,6);%initially sets player stand probabilities to zero
    for j=17:21
        if(tempSum == j)
            probN(j-16) = 1;
            %if player stands, the probability of player getting j after 
            %standing is 1
            break;
        end
    end
    prob1 = getWinP(probN,probD);
    %probability that standing wins, ties, or loses
    prob2 = getWinP(probP,probD);
    %probability that a single hit wins, ties, or loses
    p = simDeck.availableCards(i-1)/simDeck.totalCards;
    %calculates probability of getting card value
    if(prob1(1)/prob1(3) < prob2(1)/prob2(3))
    %if odds of standing and winning<odds of hitting and winning,continue hitting
        simDeck = takeCard(simDeck,i);
        %reduce current value from deck
        prob = prob + p*getLogiHitP(tempSum,simDeck,probD,soft);
        %recursive function call
        simDeck = addCard(simDeck,i);%add value back to deck                  
    else%if odds of standing > odds of hitting
        switch tempSum
            case 17
                prob(1) = prob(1) + p;
            case 18
                prob(2) = prob(2) + p;
            case 19
                prob(3) = prob(3) + p;
            case 20
                prob(4) = prob(4) + p;
            case 21
                prob(5) = prob(5) + p;
            otherwise
                if(tempSum > 21)%if possible bust
                    if(soft)
                        tempSum = tempSum - 10;%change ace value to 1
                        soft = soft - 1;%change soft flag
                        probP = getPlayerP(runTotal,simDeck,soft);
                        %recalculate player probabilities
                        probN = zeros(1,6);
                        for j=17:21
                            if(runTotal == j)
                                probN(j-16) = 1;%redetermine stand probabilities
                                break;
                            end
                        end
                        prob1 = getWinP(probN,probD);
                        %redetermines probability that standing wins, ties,
                        %or loses
                        prob2 = getWinP(probP,probD);
                        %redetermines probability that a single hit wins, 
                        %ties, or loses
                        if(prob1(1)/prob1(3) < prob2(1)/prob2(3))
                            simDeck = takeCard(simDeck,i);
                            prob = prob+p*getLogiHitP(tempSum,simDeck,probD,soft);
                            simDeck = addCard(simDeck,i);
                        else
                            switch tempSum
                                case 17
                                    prob(1) = prob(1) + p;
                                case 18
                                    prob(2) = prob(2) + p;
                                case 19
                                    prob(3) = prob(3) + p;
                                case 20
                                    prob(4) = prob(4) + p;
                                case 21
                                    prob(5) = prob(5) + p;
                            end
                        end
                        soft = soft + 1;
                    else%if not soft, then bust
                        prob(6) = prob(6) + p;
                    end
                end
        end
    end
end
end



