function [ difference ] = checkDifference( mesh1,mesh2 )

    difference = sum(sum(abs(mesh1.Location - mesh2.Location)));

end

