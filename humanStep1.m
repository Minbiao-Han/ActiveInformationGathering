function [res] = humanStep1(out, robot, human, v, d)

res = human;

if (human.x == human.xd && human.y == human.yd)
    res.x = human.xd;
    res.y = human.yd;
elseif (out.val == 1)
    res.x = human.x + v;
elseif (out.val == 0)
    res.x = human.x;
    res.y = human.y;
end

res.m = [];

if(abs(res.x - robot.x) <= d)
    res.m = robot;
else
    res.m = [];
end
