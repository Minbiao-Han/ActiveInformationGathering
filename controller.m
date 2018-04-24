function [out] = controller(in)

if (isempty(in.m))
    out.val = 1;
else
    out.val = 0;
end

