function [] = HumanStateEstimation2(s1, t1, s2, t2, timeout)

v = 1;
d = 1;

[robot, human] = initGoalParams(s1, s2, t1, t2, d);

pos1 = [];
pos2 = [];

for i = 1:timeout
    [out] = controller(human);
    
    pos1 = [pos1; robot.x robot.y];
    pos2 = [pos2; human.x human.y];

    if (robot.x == robot.xd && robot.y == robot.yd && human.x == human.xd && human.y == human.yd)
        break
    end
    
    if (i <= 5)
        robot = robotStep1(robot, v, d);
        human = humanStep1(out, robot, human, v, d);
    elseif (i > 5 && i <= 6)        
        robot = robotStep2(robot, v, d);
        human = humanStep1(out, robot, human, v, d);
    elseif (i > 10 && i <= 13)
        robot = robotStep1(robot, v, d);
    elseif (i > 13 && i <= 20)
        robot = robotStep1(robot, v, d);
        human = humanStep1(out, robot, human, v, d); 
    elseif (i > 20 && i <= 25)
        human = humanStep1(out, robot, human, v, d+1);
    elseif (i > 25 && i <= 27) 
        robot = robotStep1(robot, v, d);
    elseif (i > 27 && i <= 35)
        robot = robotStep1(robot, v, d);
        human = humanStep1(out, robot, human, v, d);
    elseif (i > 36 && i <= 40)
        human = humanStep1(out, robot, human, v, d+2);
    elseif (i > 41 && i <= 41)
        robot = robotStep1(robot, v, d);
    else 
        robot = robotStep1(robot, v, d);
        human = humanStep1(out, robot, human, v, d+3);
    end
end

for i = 1:size(pos1, 1)
    plot(pos1(1:i, 1), pos1(1:i, 2), 'b+-');
    hold on;
    plot(pos2(1:i, 1), pos2(1:i, 2), 'r+-');
    plot(pos1(i, 1), pos1(i, 2), 'sb', 'MarkerSize',12,'MarkerFaceColor','b');
    plot(pos2(i, 1), pos2(i, 2), 'sr', 'MarkerSize',12,'MarkerFaceColor','r');
    hold off;
    
    lx = min([min(pos1(:, 1)), min(pos2(:, 1)), robot.xd, human.xd]) - 1;
    rx = max([max(pos1(:, 1)), max(pos2(:, 1)), robot.xd, human.xd]) + 1;
    ly = min([min(pos1(:, 2)), min(pos2(:, 2)), robot.yd, human.yd]) - 1;
    ry = max([max(pos1(:, 2)), max(pos2(:, 2)), robot.yd, human.yd]) + 1;
    axis([lx, rx, ly, ry ])
    
    pause(.5)
end