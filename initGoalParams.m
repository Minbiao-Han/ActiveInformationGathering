function [ params1, params2 ] = initGoalParams( s1, s2, t1, t2, q)
% Initialize Goal Parameters

params1.x = s1(1);
params1.y = s1(2);
params1.xd = t1(1);
params1.yd = t1(2);

params2.x = s2(1);
params2.y = s2(2);
params2.xd = t2(1);
params2.yd = t2(2);

params1.m = [];
params2.m = [];

if(abs(params1.x - params2.x) <= q)
    params1.m = params2;
    params2.m = params1;
else 
    params1.m = [];
    params2.m = [];
end

end