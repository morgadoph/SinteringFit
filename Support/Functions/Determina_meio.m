function [ymeio] = Determina_meio(xdata)

ndados=size(xdata);

ymenor=xdata(1);
ymaior=xdata(1);

for i=1:ndados(1)
    if xdata(i) > ymaior
        ymaior = xdata(i);
    end
    if xdata(i) < ymenor
        ymenor = xdata(i);
    end
end

ymeio = (ymaior + ymenor)/2;

end