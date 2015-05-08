function [ newimage averages ] = reduceDimensions( image, newdims )

dims = size(image);
newimage = zeros( newdims );
averages = zeros(newdims);

dx = 1.0 / dims(1);
dy = 1.0 / dims(2);

newDX = 1.0/newdims(1);
newDY = 1.0/newdims(2);

m=1;
newxA = 0;
newxB = m*newDX;

for i=1:dims(1)
    
    xA = (i-1)*dx;
    xB = i*dx;
    
    have_x_overlap=0;
    
    if ( xA > newxB ) 
        m=m+1;
        newxA = (m-1)*newDX;
        newxB = m*newDX;
    end

    
    if ( xA < newxA && xB > newxA ) 
        
        have_x_overlap=1;
        partialX = xB - newxA; 
        
    elseif ( xA < newxB && xB > newxB )
        
        have_x_overlap=1;
        partialX = newxB - xA;
    
    end
    
    x_contained=0;
    if ~have_x_overlap
        x_contained = xA >= newxA && xB <= newxB;
        
        if x_contained 
            partialX = dx;
        end
    end
    
    
    
    n=1;
    newyA=0;
    newyB = n*newDY;
    
    for j=1:dims(2)
   
        yA = (j-1)*dy;
        yB = j*dy;
        
        if ( yA > newyB ) 
            n=n+1;
            newyA = (n-1)*newDY;
            newyB = n*newDY;
        end
        
        if ( x_contained && yA >= newyA && yB <= newyB )
            %add the entire value of the old pixel at (i,j) to the new one
            %at (m,n)
            newimage(m,n) = newimage(m,n) + image(i,j);
            averages(m,n) = averages(m,n) + 1;
            
        elseif ( yA < newyA && yB > newyB )
            %add a fraction of the value of the old pixel at (i,j) to the new one
            %at (m,n), corresponding to the fraction of the old pixel inside the new one's area
            partialY = yB - newyA;
            
            newimage(m,n) = newimage(m,n) + image(i,j)*(partialX/dx)*(partialY/dy);
            averages(m,n) = averages(m,n) + (partialX/dx)*(partialY/dy);
            
        elseif ( yA < newyB && yB > newyB )
            
            partialY = newyB - yA;
            
            newimage(m,n) = newimage(m,n) + image(i,j)*(partialX/dx)*(partialY/dy);
            averages(m,n) = averages(m,n) + (partialX/dx)*(partialY/dy);
        end
        
        
        
    end
    
end

end

