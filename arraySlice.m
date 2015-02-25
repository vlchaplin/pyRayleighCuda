function [ arrslice ] = array_slice( array, index, d  )
    dims = size(array);
    ndims = length(dims);

    resultDims = dims;
    resultDims(d) = 1; 
    
    arrslice = zeros(resultDims);
    
    NNr = prod(resultDims);
    bigList = zeros([1 NNr]);
    if d==1 
        bigList(:) = index;
    else
        bigList(:) = (index-1)*prod(dims(1:d-1));
    end
    j=0; %output dimension
    for k=1:ndims  
        if k~=d
            j=j+1;
            if k==1
                lk = repmat( 1:dims(k), [1 NNr/dims(k)]);
            else
                lk = ((1:dims(k))-1)*prod(dims(1:k-1));

                for jj=1:(j-1)
                   lk = repmat( lk, [resultDims(jj) 1] ); 
                end
                for jj=(j+1):ndims-1
                   lk = repmat( lk, [1 resultDims(jj)] ); 
                end

                % k==2
                % repmat(repmat(repmat(s2,[n1 1]), [1 n3]), [1 n4])
                % k==3
                % repmat(repmat(repmat(s3,[n2 1]), [n1 1]), [1 n4])
                % k==4
                % outermost
                % repmat(repmat(repmat(s4,[n3 1]), [n2 1]), [n1 1])
                
            end
            bigList = bigList + lk(:)';
        end



    end 
    

    arrslice(:) = array(bigList);
end

