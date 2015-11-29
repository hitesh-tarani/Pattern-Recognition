function boolval=error_like(old_like,new_like)

    boolval= (abs(old_like-new_like) > 0.5);

end