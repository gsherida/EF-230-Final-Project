function count = getCount(deck,method)
%This function calculates the count based on the method provided and
%current deck of cards. The count is used by players to adjust their
%betting and as in indication of when certain bets (insurance) are
%favorable. My program allows players to check and see if their count is
%agreeing with the real count. Numerous counting systems are available to
%choose from. I only programmed balanced systems.

    countNumbers = [0 1 1 1 1 1 0 -1 -1 0;1 1 2 2 2 1 0 -1 -2 0;...
                    1 1 1 1 1 0 0 0 -1 -1;0 1 1 1 1 0 0 0 -1 0;...
                    1 1 2 2 1 1 0 0 -2 0;1 2 2 2 2 1 0 -1 -2 0;...
                    1 1 2 2 2 1 0 -1 -2 0;1 1 1 1 1 0 0 -1 -1 0;...
                    1 2 2 2 2 1 0 0 -2 -2;2 3 3 4 3 2 0 -1 -3 -4;...
                    2 2 3 4 2 1 0 -2 -3 0;1 1 1 1 1 1 0 -1 -1 -1;...
                    0 1 1 1 1 1 0 0 -1 -1;1 2 2 3 2 2 1 -1 -3 0;...
                    0.5 1 1 1.5 1 0.5 0 -0.5 -1 -1;1 1 2 2 2 1 0 0 -2 -1];
    count = 0;       
    for i=1:10
        mult = 4;
        if(i == 9)
            mult = 16;
        end
        count = count+countNumbers(method,i)*(mult*deck.numDecks-deck.availableCards(i));
    end
end

