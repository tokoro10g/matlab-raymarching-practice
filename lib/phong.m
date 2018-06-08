function col = phong(normal, raydir, lightdir, lightspec, matspec)
l_d = dot(lightdir,normal,3);
col = matspec.k_a*lightspec.i_a + ...
    matspec.k_d*l_d.*lightspec.i_d + ...
    matspec.k_s*dot((2*l_d.*normal-lightdir),-raydir,3).^matspec.alpha.*lightspec.i_s;
end

