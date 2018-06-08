function out = getnormal(p, dist)
d = 0.0001;
dx = third([d;0;0]);
dy = third([0;d;0]);
dz = third([0;0;d]);
out = cat(3,...
    dist(p+dx)-dist(p-dx),...
    dist(p+dy)-dist(p-dy),...
    dist(p+dz)-dist(p-dz));
out = out./vecnorm(out,2,3);
end