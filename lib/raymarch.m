function [ray, d] = raymarch(dist,campos,raydir,iter)

sz = size(raydir);
res = [sz(2) sz(1)];
t = zeros(res(2),res(1),1);
ray = spread_xy(campos,res);
porig = ray;

for k=1:iter
    d = dist(ray);
    t = t + d;
    ray = porig + t.*raydir;
end

end

