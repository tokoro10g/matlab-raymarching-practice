clear

addpath ./lib

%% Initialization

res = [240 160];

[X, Y] = meshgrid(1:res(1), res(2):-1:1);

X = (X*2-res(1))/res(2);
Y = (Y*2-res(2))/res(2);

campos = third([3; 1.5; 3]);
camdir = normalize3(third([-1; -0.5; -1]));
camup = normalize3(third([0; 1; 0]));
camside = cross(camdir,camup);
focus = 3;

testlight = struct();
testlight.pos = third([4; 0; 100]);
testlight.i_a = third([1; 0; 0]);
testlight.i_d = third([1; 1; 1]);
testlight.i_s = third([1; 1; 1]);

testmaterial = struct();
testmaterial.k_a = 0.6;
testmaterial.k_d = 0.4;
testmaterial.k_s = 0.5;
testmaterial.alpha = 8;

raydir = spread_xy(camside,res).*repmat(X,[1,1,3])...
    + spread_xy(camup,res).*repmat(Y,[1,1,3])...
    + spread_xy(camdir,res) * focus;
raydir = normalize3(raydir);


%% Raymarching
tic;

dist = @(p)(vecnorm(p,2,3)-1.0);
[posonray, d] = raymarch(dist,campos,raydir,64);

normal = getnormal(posonray,dist);
lightdir = normalize3(spread_xy(testlight.pos,res) - posonray);

% Apply Phong Reflection Model
c = phong(normal, raydir, lightdir, testlight, testmaterial);

colmap = double(abs(d)<0.001).*c;
colmap(colmap>1)=1;

ta = toc

imshow(colmap)