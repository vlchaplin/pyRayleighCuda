function [ filterXtoY ] = bin2binFilter( X, Y )
% function [ filterXtoY ] = bin2binFilter( X, Y )  
%   X - original Bins (length N)
%   Y - new Bins (length M)
%
%   Returns matrix F (size M x N) 
%
%  Use like:
%       F =  bin2binFilter( X, Y );
%       vecY = F*vecX'; (if vecX has binning X and size is [1 N])

    N = length(X);
    M = length(Y);
    
    filterXtoY = zeros([M N]);
    
    n = 1;
    m = 1;

    while (n<N && m < M)
        
        
        
        xa = X(n);
        xb = X(n+1);
        
        ya = Y(m);
        yb = Y(m+1);
        
        %X:   a    b
        %     |    |
        %  | |
        %Y:a b 
        if xa >= yb
            m = m+1;
            continue;
        end
        
        %X: a    b
        %   |    |
        %         | |
        %Y:       a b 
        if ya >= xb
            n = n+1;
            continue;
        end
        
        %X:  a    b
        %    |--  |
        %   |  |
        %Y: a  b 
        if ya <= xa && yb > xa
            filterXtoY(m,n) = filterXtoY(m,n) + (yb - xa)/(xb - xa);
            m = m+1;
            continue;
        end
        
        %X:  a    b
        %    |   -|
        %        |  |
        %Y:      a  b 
        if ya > xa && yb >= xb
            filterXtoY(m,n) = filterXtoY(m,n) + (xb - ya)/(xb - xa);
%             if n < N
%                 filterXtoY(m,n+1) = filterXtoY(m,n+1) + (xb - ya)/(xb - xa);
%             end
            n = n+1;
            continue;
        end
        
        %X:  a    b
        %    |----|
        %   |      |
        %Y: a      b 
        if ya <= xa && yb >= xb
            filterXtoY(m,n) = filterXtoY(m,n) + 1;
            n = n+1;
            continue;
        end
        
        %X: a      b
        %   | ---- |
        %     |  |
        %Y:   a  b 
        if ya > xa && yb < xb
            filterXtoY(m,n) = filterXtoY(m,n) + (yb-ya)/(xb-xa);
            m = m+1;
            continue;
        end
        
        
    end

end

