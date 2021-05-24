% first draft of the tictactoe player for BME60B 2021 summer

gamestate= initializegamtestate();
historyofgamestate = gamestate;
loopcounter = 2;
while gamestate.finish == false
    
    if gamestate.turn ==1
        move = player1(gamestate);  
    elseif gamestate.turn == -1
        move = player2(gamestate);
    else
        print('error')
    end
    gamestate = makeamove(gamestate,move);
    drawmove(gamestate,move)
    historyofgamestate(loopcounter) =gamestate; 
    loopcounter = loopcounter +1;                                           %increment counter
    drawnow
    pause(1)                                                                %wait 1 second before going
end

if gamestate.turn ==1
winningplayer = '1';
elseif gamestate.turn ==-1
winningplayer = '2'  ;
else
    print('error')
end
title(['Winner is player ' winningplayer])                                  
save('game1.mat','historyofgamestate')                                      %saves the game so we can look at it later



%% subfunctions 
% I decided to include everything in one file for easier download/sharing
% but sacrificing modularity and readability. 

function drawmove(gamestate,move)
    % check that there is only 1 move 
    [row,col] = find(move);
    if length(row)  ~= 1  && length(col)  ~= 1
        print('move error')
    end
    
    figure(1)
    hold on
    if gamestate.turn == 1
        rectangle('Position',[row-0.8,-(col-0.2),0.6,0.6],'Curvature',[1 1])
    elseif gamestate.turn == -1
        plot([row-0.8 row-0.2],[-(col-0.2) -(col-0.8)],'k')
        plot([row-0.8 row-0.2],[-(col-0.8) -(col-0.2)],'k')
    end
    hold off
    
end


function gamestate = initializegamtestate
    gamestate.board = zeros(3);
    gamestate.turn = 1;
	gamestate.finish = false;
    
    
    figure(1)
    plot([0 3],-[1 1], 'k','linewidth',2);
    hold on
    plot([0 3],-[2 2], 'k','linewidth',2)
    plot([1 1],-[0 3], 'k','linewidth',2)
    plot([2 2],-[0 3], 'k','linewidth',2)
    hold off
    axis off
end


function gamestate = makeamove(gamestate,move)
    % check that there is only 1 move 
    [row,col] = find(move);
    if length(row)  ~= 1  && length(col)  ~= 1
        print('move error')
    end
    
    %check if the move is legal
    if  gamestate.board(row,col) ~=0
        print('move error 2')
    end
    
    gamestate.board = gamestate.board + move*gamestate.turn;
    gamestate.turn = gamestate.turn*-1;
    
    %check for winner
    checkfor = [sum(gamestate.board,1), sum(gamestate.board,2)',gamestate.board(1,1)+gamestate.board(2,2)+gamestate.board(3,3),gamestate.board(1,3)+gamestate.board(2,2)+gamestate.board(3,1)] ;
    if  any( abs(checkfor) == 3)
        gamestate.finish = true;
    end
end

function move = player1(gamestate)
    legal = false;
    while legal == false
        row= randi([1,3]);
        col= randi([1,3]);
        if gamestate.board(row,col) == 0
            legal = true;
        end
    end
    move = zeros(3);
    move(row,col) = 1;
end


function move = player2(gamestate)
    legal = false;
    while legal == false
        row= randi([1,3]);
        col= randi([1,3]);
        if gamestate.board(row,col) == 0
            legal = true;
        end
    end
    move = zeros(3);
    move(row,col) = 1;
end