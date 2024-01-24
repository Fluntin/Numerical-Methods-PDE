function result = integrate(fun, start, stop)
    
stepSize = 0.001;
    result = 0;

    for x = start:stepSize:stop
        result = result + fun(x) * stepSize;
    end
end