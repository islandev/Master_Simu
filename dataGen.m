function [ rc ] = dataGen( c,row,col )


rc=[];

res=50/(row*col);
 for i=1:size(c,2)
    if(c(i)>0) rc(i)=c(i)+rand*res;
    else rc(i)=c(i);
    end
 end



end

