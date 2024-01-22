function uValues = getUValues(K, h, v_hat, f_hat) 
    uValues = zeros(K, K);
    v_bar = @(x) generate_fourier_row(x, 169) * v_hat;
    euler_forward = @(x) x - h * real(v_bar(x));   % real to make it v_tilda
    f_bar = @(x) generate_fourier_row(x, 169) * f_hat;
    % check lab notes 
    for k1 = 1:K
        for k2 = 1:K
            xn = [k1/K, k2/K];
            temp_xn = xn;

            while (xn(1)> 0 && xn(2)> 0)  
                xn = euler_forward(xn);  % if xn in the rand its 0
                temp_xn = [temp_xn; xn]; % Save all the values of xn to calculate it back
            end

            temp_u = 0;
            for l = 1:size(temp_xn, 1)
                temp_u = temp_u + real(f_bar(temp_xn(l, :)));  %real to make it tilda
            end                                        % order doesnt matter since its just a sum
            temp_u = temp_u* h;
            uValues(k1, k2) = temp_u;
        end
    end
uValues = [uValues; zeros(1, K)]; 
uValues = [zeros(K+1, 1), uValues]; %BVP
end
