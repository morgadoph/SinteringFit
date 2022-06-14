function F = sigmoidalmod(x0,xdata)

ndados=size(xdata);
F=zeros(ndados(1),1);
for i=1:ndados(1)
    F(i)=62.7+(100-62.7)/(1+exp((-xdata(i)+x0(1))/x0(2)));
end

end
