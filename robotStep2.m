function [res] = robotStep2(in, v, d)

res = in;
if (in.x == in.xd && in.y == in.yd)
    res.x = in.x;
    res.y = in.y;
else
    res.x = in.x;
    res.y = in.y + v;
end