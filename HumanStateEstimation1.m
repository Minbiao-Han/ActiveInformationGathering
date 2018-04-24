function [] = HumanStateEstimation1(s1, t1, s2, t2, timeout)

%Runs the simulation until timeout
%s1: Source location of robot-driven car
%t1: Target location of robot-driven car
%s2: Source location of human-driven car
%t2: Target location of human-driven car
%timeout: Number of steps the simulation is run

%v: Velocity of aircraft
%d: Awareness of the human driver
v = 1;
d = 1;

[robot, human] = initGoalParams(s1, s2, t1, t2, d);

pos1 = [];
pos2 = [];

for i = 1:timeout
    %[out1] = controller(robot);
    [out] = controller(human);
    
    pos1 = [pos1; robot.x robot.y];
    pos2 = [pos2; human.x human.y];

    if (robot.x == robot.xd && robot.y == robot.yd && human.x == human.xd && human.y == human.yd)
        break
    end
    
    if (i <= 5)
        robot = robotStep1(robot, v, d);
        human = humanStep1(out, robot, human, v, d);
    elseif (i > 5 && i <= 10)
        human = humanStep1(out, robot, human, v, 1); 
    elseif (i > 10 && i <= 13)
        robot = robotStep1(robot, v, d);
    elseif (i > 13 && i <= 22)
        robot = robotStep1(robot, v, d);
        human = humanStep1(out, robot, human, v, d); 
    elseif (i > 22 && i <= 26)
        human = humanStep1(out, robot, human, v, 2);
    elseif (i > 26 && i <= 28) 
        robot = robotStep1(robot, v, d);
    elseif (i > 28 && i <= 45)
        robot = robotStep1(robot, v, d);
        human = humanStep1(out, robot, human, v, d);
    elseif (i > 45 && i <= 50)
        human = humanStep1(out, robot, human, v, 2);
    elseif (i > 50 && i <= 52)
        robot = robotStep1(robot, v, d);
    elseif (i > 52 && i <= 82) 
        robot = robotStep1(robot, v, d);
        human = humanStep1(out, robot, human, v, 0);
    else
        human = humanStep1(out, robot, human, v, 0);
    end
end

for i = 1:size(pos1, 1)
    plot(pos1(1:i, 1), pos1(1:i, 2), 'b+-');
    hold on;
    plot(pos2(1:i, 1), pos2(1:i, 2), 'r+-');
    plot(pos1(i, 1), pos1(i, 2), 'sb', 'MarkerSize',12,'MarkerFaceColor','b');
    plot(pos2(i, 1), pos2(i, 2), 'sr', 'MarkerSize',12,'MarkerFaceColor','r');
    if (pos1(i, 1) == pos2(i, 1))
        plot(pos2(i, 1), pos2(i, 2), '*r', 'MarkerSize',30,'MarkerFaceColor','r');
    end
    hold off;
    
    % axis
    lx = min([min(pos1(:, 1)), min(pos2(:, 1)), robot.xd, human.xd]) - 1;
    rx = max([max(pos1(:, 1)), max(pos2(:, 1)), robot.xd, human.xd]) + 1;
    ly = min([min(pos1(:, 2)), min(pos2(:, 2)), robot.yd, human.yd]) - 1;
    ry = max([max(pos1(:, 2)), max(pos2(:, 2)), robot.yd, human.yd]) + 1;
    axis([lx, rx, ly, ry ])
    
    pause(.5)
end

%plot(80, 0, '*r', 'MarkerSize',12,'MarkerFaceColor','r');
