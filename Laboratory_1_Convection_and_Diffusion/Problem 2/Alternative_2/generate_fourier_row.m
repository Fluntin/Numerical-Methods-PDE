function fourier_row = generate_fourier_row(x, n)
    fourier_row = zeros(1,n);
    col_index = 1;
    for n1 = -6:6
        for n2 = -6:6
            fourier_row(col_index) = exp(2*pi*1i*(n1*x(1) + n2*x(2)));
            col_index = col_index + 1;
        end
    end
    
end
    