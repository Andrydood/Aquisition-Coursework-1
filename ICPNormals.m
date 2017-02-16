function [ outputMesh ] = ICPNormals( mesh1,mesh2 )

    %Get data from the 2 meshes
    originalPoints1 = mesh1.Location;
    originalPoints2 = mesh2.Location;
    
    originalNormals = pcnormals(mesh1);
    
    meshSize1 = mesh1.Count;
    meshSize2 = mesh2.Count;
    
    pointAmount = ceil(mesh1.Count);
    
    points1 = zeros(pointAmount,3);
    points2 = zeros(pointAmount,3);
    normals = zeros(pointAmount,3);
    
    for i = 1:pointAmount
        
        
        val = floor(meshSize1*rand(1)+1);
        
        points1(i,:) = originalPoints1(val,:);
        
        normals(i,:) = originalNormals(val,:);
        
        points2(i,:) = originalPoints2(floor(meshSize2*rand(1)+1),:);
        
    end
    
    %Find closest point from points2 for each point in points1
    
    [closestPoints, closestValues] = knnsearch(points2, points1);
    
    %Rearrange points 2 to be in the order of closest points to points1
    
    points2_new = zeros(pointAmount,3);
    
    for i = 1:pointAmount
        
        points2_new(i,:) = points2(closestPoints(i),:);
        
    end
    
    
    %Build calculate A and b
    
    A = zeros(pointAmount,6);
    b = zeros(pointAmount,1);

    for i = 1:pointAmount
        
        A(i,:) = [cross(points2_new(i,:),normals(i,:)) normals(i,:)];
        b(i,:) = dot(-(points2_new(i,:)-points1(i,:)),normals(i,:));
       
    end

    %Solve for Ax=b
    x = (A'*A)\(A'*b);
    
    transform = makehgtform('xrotate',x(1),'yrotate',x(2),'zrotate',x(3),'translate',[x(4) x(5) x(6)]);
    
    outputMesh = pctransform(mesh2,affine3d(transform'));
    
end

