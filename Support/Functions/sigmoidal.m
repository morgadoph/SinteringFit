function F = sigmoidal(x0,xdata)

ndados=size(xdata);
F=zeros(ndados(1),1);
for i=1:ndados(1)
    F(i)=x0(1)+(100-x0(1))/(1+exp((-xdata(i)+x0(2))/x0(3)));
end

end
