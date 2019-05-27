function invhform=invhform(hform)

if(~isequal(size(hform),[4 4]))
    error('invhform received malformed homogeneous transform')
end

if(norm(hform(1:3,1:3)*hform(1:3,1:3)'-eye(3))>1e-6)
    error('invhform received malformed homogeneous transform')
end
invrot=[hform(1:3,1:3)';0 0 0];
invpos=[-hform(1:3,1:3)'*hform(1:3,4);1];
invhform=[invrot,invpos];

